import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum ApproveDialogType {
  notificationPermission(LocaleKeys.dialog_permissionNotification),
  cameraPermission(LocaleKeys.dialog_permissionCameraLibrary),
  libraryPermission(LocaleKeys.dialog_permissionCameraLibrary)
  ;

  const ApproveDialogType(this.key);

  final String key;
}
