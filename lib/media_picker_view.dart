import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_view/repository/get_thumbnail_provider.dart';
import 'package:media_picker_view/static/media_picker_type.dart';
import 'package:media_picker_view/util/media_type_checker.dart';
import 'package:media_picker_view/widget/empty_preview_widget.dart';

/// A media preview widget that supports images & videos.
class MediaPreviewList extends StatelessWidget {
  final List<XFile> files;
  final void Function(int index) onRemove;
  // final Widget placeholder;
  final Function(XFile? file)? onSelect;
  final Function(List<XFile>? files)? onMultiSelect;
  final MediaPickerType mediaPickerType;

  /// Custom colors
  final Color loaderColor;
  final double previewWidth;
  final double previewHeight;

  const MediaPreviewList({
    super.key,
    required this.files,
    required this.onRemove,
    this.loaderColor = Colors.orange,
    this.previewWidth = 150,
    this.previewHeight = 200,
    this.onSelect,
    this.onMultiSelect,
    // this.placeholder = const EmptyPreviewWidget(),
    this.mediaPickerType = MediaPickerType.media,
  });

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return EmptyPreviewWidget(mediaPickerType: mediaPickerType);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      height: previewHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          final isVideo = isVideoFile(file.path);

          return Padding(
            padding: EdgeInsets.only(right: index < files.length - 1 ? 8 : 0),
            child: Stack(
              children: [
                buildMediaPreview(context, file, isVideo),

                // Media type icon
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isVideo ? Icons.videocam : Icons.image,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),

                // Remove button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => onRemove(index),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMediaPreview(BuildContext context, XFile file, bool isVideo) {
    if (isVideo) {
      return ProviderScope(
        child: Consumer(
          builder: (context, ref, _) {
            final thumbnailAsync = ref.watch(getThumbnailProvider(file.path));
            return thumbnailAsync.when(
              data: (thumbFile) => _buildImage(File(thumbFile!.path)),
              loading: () => _buildLoader(),
              error: (_, __) => _buildError(),
            );
          },
        ),
      );
    } else {
      return _buildImage(File(file.path));
    }
  }

  Widget _buildImage(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        file,
        width: previewWidth,
        height: previewHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      width: previewWidth,
      height: previewHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox.square(
        dimension: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          strokeCap: StrokeCap.round,
          color: loaderColor,
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      width: previewWidth,
      height: previewHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.error, color: Colors.red),
    );
  }
}
