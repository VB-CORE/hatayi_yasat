part of '../settings_view.dart';

@immutable
final class _ChangeNotificationWidget extends StatelessWidget {
  const _ChangeNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GeneralGroupSectionHeader(
          label: LocaleKeys.settings_notificationTitle
              .tr(context: context)
              .toUpperCase(),
        ),
        const NotificationPermissionView(),
      ],
    );
  }
}
