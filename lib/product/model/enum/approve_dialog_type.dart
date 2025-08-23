import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum ApproveDialogType {
  notificationPermission(LocaleKeys.dialog_permissionNotification),
  cameraPermission(LocaleKeys.dialog_permissionCameraLibrary),
  libraryPermission(LocaleKeys.dialog_permissionCameraLibrary);

  final String key;

  // ignore: sort_constructors_first
  // This constructor order is intentional for better readability
  const ApproveDialogType(this.key);
}
