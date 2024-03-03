import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/notification_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/notifier/loading_notifier.dart';

final class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

final class _NotificationsViewState extends State<NotificationsView>
    with
        LoadingNotifier<NotificationsView>,
        NotificationTypeMixin,
        NotificationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.home_notifications).tr(),
        actions: [
          _Loading(loadingNotifier: loadingNotifier),
        ],
      ),
      body: FirestoreListView<AppNotificationModel?>(
        query: reference(),
        emptyBuilder: (_) =>
            GeneralNotFoundWidget(title: LocaleKeys.notFound_notification.tr()),
        loadingBuilder: (context) => const PlaceShimmerList(),
        itemBuilder: (context, doc) {
          final model = doc.data();
          if (model == null || model.id.isEmpty) return const SizedBox.shrink();
          return Column(
            children: [
              ListTile(
                tileColor: context.general.colorScheme.secondary,
                contentPadding: const PagePadding.defaultPadding(),
                dense: true,
                leading: _NotificationTypeLeadingIcon(model: model),
                onTap: () => navigateToDetail(model),
                title: Text(model.body ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.createdAt != null)
                      Padding(
                        padding: const PagePadding.onlyTopLow(),
                        child: Text(
                          DateTimeFormatter.formatValueDetail(
                            model.createdAt!,
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: _NotificationTypeTrailingIcon(model.type),
              ),
              const _CustomDivider(),
            ],
          );
        },
        // ...
      ),
    );
  }
}

final class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.general.colorScheme.onBackground.withOpacity(0.5),
      height: AppConstants.kZero.toDouble(),
      thickness: AppConstants.kZero.toDouble(),
    );
  }
}

final class _NotificationTypeTrailingIcon extends StatelessWidget {
  const _NotificationTypeTrailingIcon(this.type);
  final AppNotificationType? type;
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.chevron_right_outlined)
        .ext
        .toVisible(value: type != AppNotificationType.advertise);
  }
}

final class _NotificationTypeLeadingIcon extends StatelessWidget {
  const _NotificationTypeLeadingIcon({
    required this.model,
  });

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    if (model.type == null) return const SizedBox();
    return switch (model.type!) {
      AppNotificationType.store => const Icon(Icons.home_outlined),
      AppNotificationType.campaign => const Icon(Icons.campaign_outlined),
      AppNotificationType.news => const Icon(Icons.newspaper_outlined),
      AppNotificationType.advertise =>
        const Icon(Icons.notifications_active_outlined),
      // TODO: Handle this case.
      AppNotificationType.link => throw UnimplementedError(),
    };
  }
}

final class _Loading extends StatelessWidget {
  const _Loading({
    required this.loadingNotifier,
  });

  final ValueNotifier<bool> loadingNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: loadingNotifier,
      child: const Padding(
        padding: PagePadding.allLow(),
        child: CircularProgressIndicator(),
      ),
      builder: (BuildContext context, bool value, Widget? child) {
        if (!value) return const SizedBox.shrink();
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
