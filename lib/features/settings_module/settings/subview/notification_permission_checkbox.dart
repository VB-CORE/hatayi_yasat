import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/approve_dialog_type.dart';
import 'package:vbaseproject/product/package/settings/custom_app_settings.dart';
import 'package:vbaseproject/product/widget/dialog/approve_dialog.dart';
import 'package:vbaseproject/product/widget/general/title/general_body_title.dart';

@immutable
final class NotificationPermissionView extends StatefulWidget {
  const NotificationPermissionView({super.key});
  @override
  State<NotificationPermissionView> createState() =>
      _NotificationPermissionViewState();
}

final class _NotificationPermissionViewState
    extends State<NotificationPermissionView> with _NotificationPermission {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
      future: Permission.notification.status,
      builder:
          (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
        final isGranted = snapshot.data == PermissionStatus.granted ||
            snapshot.data == PermissionStatus.limited;

        /// When user is enabled to notifications we are ignoring the widget
        /// if u want to change it can be change manually
        return IgnorePointer(
          ignoring: isGranted,
          child: AnimatedOpacity(
            duration: Durations.medium2,
            opacity: isGranted ? 0.3 : 1,
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: isGranted,
              onChanged: (value) {
                _controlCheckBox(value: value ?? false);
              },
              title: GeneralBodyTitle(
                LocaleKeys.settings_notificationSetting.tr(context: context),
              ),
            ),
          ),
        );
      },
    );
  }
}

mixin _NotificationPermission on State<NotificationPermissionView> {
  bool _isRequestAsking = false;
  void _changeRequestAsking() {
    _isRequestAsking = !_isRequestAsking;
  }

  Future<void> _controlCheckBox({required bool value}) async {
    if (_isRequestAsking) return;
    if (!value) return;
    _changeRequestAsking();
    final response = await ApproveDialog.showWithKey(
      context: context,
      type: ApproveDialogType.notificationPermission,
    );
    _changeRequestAsking();
    if (!response) return;
    CustomAppSettings.open(
      type: CustomAppSettingsType.notification,
    );
  }
}
