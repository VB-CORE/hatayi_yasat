abstract interface class NotificationPermission {
  bool get isSupported;

  Future<bool> isGranted();
}
