class VideoData {

  const VideoData({
    required this.name,
    required this.path,
    required this.type,
  });
  final String name;
  final String path;
  final VideoType type;
}

enum VideoType {
  asset,
  file,
  network,
  recorded,
}
