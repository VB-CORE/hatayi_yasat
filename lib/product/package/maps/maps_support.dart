abstract interface class MapsSupport {
  Future<void> load();

  bool get supportsMyLocation;
}
