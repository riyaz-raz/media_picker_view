import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

final getThumbnailProvider = FutureProvider.family<XFile?, String>((
  ref,
  videoUrl,
) async {
  final cacheManager = DefaultCacheManager();
  final cachedFile = await cacheManager.getFileFromCache(videoUrl);

  if (cachedFile != null && cachedFile.file.existsSync()) {
    return XFile(cachedFile.file.path); // Return cached file if exists
  }
  try {
    final fileName = await generateVideoThumb(videoUrl, 300);

    await cacheManager.putFile(videoUrl, File(fileName.path).readAsBytesSync());
    return fileName;
  } catch (err) {
    return null;
  }
});

Future<XFile> generateVideoThumb(String path, int thumbWidth) async {
  final thumb = await VideoThumbnail.thumbnailFile(
    video: path,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: thumbWidth,
    quality: 90,
  );

  return thumb;
}
