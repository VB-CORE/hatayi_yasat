import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/approve_dialog_type.dart';
import 'package:lifeclient/product/package/settings/custom_app_settings.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/dialog/approve_dialog.dart';
import 'package:lifeclient/product/widget/general/general_switch_tile.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
final class NotificationPermissionView extends StatefulWidget {
  const NotificationPermissionView({super.key});
  @override
  State<NotificationPermissionView> createState() =>
      _NotificationPermissionViewState();
}

final class _NotificationPermissionViewState
    extends State<NotificationPermissionView>
    with WidgetsBindingObserver, _NotificationPermission {
  late Future<PermissionStatus> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = Permission.notification.status;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    setState(() {
      _statusFuture = Permission.notification.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
      future: _statusFuture,
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
            child: GeneralSwitchTile(
              icon: AppIcons.notifications,
              label: LocaleKeys.settings_notificationSetting.tr(
                context: context,
              ),
              value: isGranted,
              onChanged: (value) => _controlCheckBox(value: value),
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
