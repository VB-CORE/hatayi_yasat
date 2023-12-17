part of '../settings_view.dart';

final class _ChangeNotificationWidget extends StatelessWidget {
  const _ChangeNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return const GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_notificationtitle,
      children: [
        NotificationPermissionView(),
      ],
    );
  }
}


//
// Notification açıp kapatmayı switch olarak yapmak istersek:
//

// final class _ChangeNotificationWidget extends StatefulWidget {
//   const _ChangeNotificationWidget();

//   @override
//   State<_ChangeNotificationWidget> createState() =>
//       _ChangeNotificationWidgetState();
// }

// final class _ChangeNotificationWidgetState extends State<_ChangeNotificationWidget>
//     with _NotificationPermission {
//   @override
//   Widget build(BuildContext context) {
//     return GeneralExpansionTile(
//       pageTitle: LocaleKeys.settings_notificationSetting.tr(),
//       children: [
//         ValueListenableBuilder(
//           valueListenable: _permissionStatusNotifier,
//           builder: (_, isAllowed, __) => GeneralSwitch(
//             title: isAllowed ? 'Açık' : 'Kapalı',
//             value: isAllowed,
//             onChanged: _controlCheckBox,
//           ),
//         ),
//       ],
//     );
//   }
// }

// mixin _NotificationPermission on State<_ChangeNotificationWidget> {
//   bool _isRequestAsking = false;
//   final ValueNotifier<bool> _permissionStatusNotifier = ValueNotifier(false);

//   void _changeRequestAsking() => _isRequestAsking = !_isRequestAsking;

//   @override
//   void initState() {
//     super.initState();
//     _listenForPermissionStatus();
//   }

//   Future<void> _listenForPermissionStatus() async {
//     final status = await Permission.notification.status;
//     _permissionStatusNotifier.value = status == PermissionStatus.granted ||
//         status == PermissionStatus.limited;
//   }

//   Future<void> _controlCheckBox(bool value) async {
//     if (_isRequestAsking) return;
//     if (!value) return;
//     _changeRequestAsking();
//     final response = await ApproveDialog.showWithKey(
//       context: context,
//       type: ApproveDialogType.notificationPermission,
//     );
//     _changeRequestAsking();
//     if (!response) return;
//     CustomAppSettings.open(
//       type: CustomAppSettingsType.notification,
//     );
//     await _listenForPermissionStatus();
//   }
// }
