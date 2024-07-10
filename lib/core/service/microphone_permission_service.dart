import 'package:lifeclient/core/service/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

final class MicrophonePermissionService extends PermissionService {
  /// Check if the permission is granted
  ///
  /// Return true if the permission is granted
  @override
  Future<bool> checkPermission() async {
    final status = await Permission.microphone.status;
    return status == PermissionStatus.granted;
  }

  /// Request the permission
  ///
  /// Return true if the permission is granted
  @override
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
}
