abstract interface class AppBadge {
  Future<bool> isSupported();

  Future<void> update(int count);
}
