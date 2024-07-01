part of '../settings_view.dart';

@immutable
final class _ChangeNotificationWidget extends StatelessWidget {
  const _ChangeNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return GeneralExpansionTile(
      key: ValueKey(context.locale),
      pageTitle: LocaleKeys.settings_notificationTitle.tr(),
      children: const [
        Padding(
          padding: PagePadding.horizontalLowSymmetric(),
          child: NotificationPermissionView(),
        ),
      ],
    );
  }
}
