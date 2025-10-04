bool isVideoFile(String filePath) {
  final ext = filePath.split('.').last.toLowerCase();
  return videoExtensions.contains(ext);
}

const List<String> videoExtensions = [
  'mp4',
  'mov',
  'avi',
  'mkv',
  'flv',
  'wmv',
  'webm',
  'm4v',
  'mpeg',
  'mpg',
  '3gp',
  'ts',
  'mts',
  'm2ts',
  'vob',
  'ogv',
];
