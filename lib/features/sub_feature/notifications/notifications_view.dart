import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/notification_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/notifier/loading_notifier.dart';
import 'package:lifeclient/product/widget/tap_area/tap_area.dart';

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
        title: Text(
          LocaleKeys.home_notifications,
          style: context.general.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ).tr(),
        actions: [
          _Loading(loadingNotifier: loadingNotifier),
        ],
      ),
      body: FirestoreListView<AppNotificationModel?>(
        query: reference(),
        padding: const PagePadding.horizontalSymmetric(),
        emptyBuilder: (_) =>
            GeneralNotFoundWidget(title: LocaleKeys.notFound_notification.tr()),
        loadingBuilder: (context) => const PlaceShimmerList(),
        itemBuilder: (context, doc) {
          final model = doc.data();
          if (model == null || model.id.isEmpty) return const SizedBox.shrink();

          return TapArea(
            onTap: () => navigateToDetail(model),
            child: Card(
              elevation: kZero,
              color: context.general.colorScheme.onPrimaryFixed,
              child: Padding(
                padding: const PagePadding.generalAllLow(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NotificationTypeLeadingIcon(model: model),
                    const EmptyBox.middleWidth(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _NotificationTypeTitle(model: model),
                          Padding(
                            padding: const PagePadding.onlyTopLow(),
                            child: Text(
                              _title(model) ?? '',
                              style: context.general.textTheme.labelSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // ...
      ),
    );
  }

  String? _title(AppNotificationModel model) =>
      model.type == AppNotificationType.link ? model.title : model.body;
}

final class _NotificationTypeLeadingIcon extends StatelessWidget {
  const _NotificationTypeLeadingIcon({
    required this.model,
  });

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    if (model.type == null) return const SizedBox.shrink();
    return switch (model.type!) {
      AppNotificationType.store => const Icon(Icons.home),
      AppNotificationType.campaign => const Icon(Icons.campaign),
      AppNotificationType.news => const Icon(Icons.newspaper),
      AppNotificationType.advertise => const Icon(Icons.notifications_active),
      AppNotificationType.link => const Icon(Icons.link),
    };
  }
}

final class _NotificationTypeTitle extends StatelessWidget {
  const _NotificationTypeTitle({
    required this.model,
  });

  final AppNotificationModel model;

  String _title(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.store => 'Yeni mekan',
      AppNotificationType.campaign => 'Yeni Kampanya',
      AppNotificationType.news => 'Yeni Haber',
      AppNotificationType.advertise => 'Yeni Duyuru',
      AppNotificationType.link => 'Yeni Bağlantı',
    };
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.general.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
    );
    if (model.type == null) return const SizedBox.shrink();
    return Row(
      children: [
        Text(
          _title(model.type!),
          style: textStyle,
        ),
        const Spacer(),
        if (model.createdAt != null)
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: Text(
              DateFormat.yMMMMd().format(
                model.createdAt!,
              ),
              style: context.general.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.general.colorScheme.onSecondaryFixed,
              ),
            ),
          ),
      ],
    );
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
