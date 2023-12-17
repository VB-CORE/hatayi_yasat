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
