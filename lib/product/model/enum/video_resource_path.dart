enum VideoResourcePath {
  republic('video_republic');

  const VideoResourcePath(this.value);
  final String value;

  String get withAsset => 'assets/videos/$value.mp4';
}
