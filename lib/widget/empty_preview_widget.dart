import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_view/static/media_picker_type.dart';

class EmptyPreviewWidget extends StatelessWidget {
  final MediaPickerType mediaPickerType;
  const EmptyPreviewWidget({super.key, required this.mediaPickerType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final picker = ImagePicker();
        final _ = switch (mediaPickerType) {
          MediaPickerType.image => picker.pickImage(
            source: ImageSource.gallery,
          ),
          MediaPickerType.video => picker.pickVideo(
            source: ImageSource.gallery,
          ),
          _ => picker.pickMedia(),

          // mediaPickerDialog(context),
        };
      }, // open the dialog
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const Center(
            child: Icon(Icons.image_outlined, color: Colors.grey, size: 40),
          ),
        ),
      ),
    );
  }
}
