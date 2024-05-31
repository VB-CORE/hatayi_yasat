abstract class PermissionService {
  /// Check if the permission is granted
  Future<bool> checkPermission();

  /// Request the permission
  Future<bool> requestPermission();

  /// Ensure the permission is granted
  Future<bool> ensurePermission() async {
    if (await checkPermission()) {
      return true;
    } else {
      return requestPermission();
    }
  }
}
