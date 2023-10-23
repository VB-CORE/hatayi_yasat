enum VideoResourcePath {
  republic('video_republic');

  final String value;
  const VideoResourcePath(this.value);

  String get withAsset => 'assets/videos/$value.mp4';
}
