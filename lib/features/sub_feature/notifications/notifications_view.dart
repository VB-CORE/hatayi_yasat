import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/notification_mixin.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/list_tile/v2_notification_tile.dart';
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
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          LocaleKeys.home_notifications.tr(),
          style: V2Typography.display(
            fontSize: 22,
            color: colorScheme.primary,
          ),
        ),
        actions: [_Loading(loadingNotifier: loadingNotifier)],
      ),
      body: FirestoreListView<AppNotificationModel?>(
        query: reference(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        emptyBuilder: (_) =>
            GeneralNotFoundWidget(title: LocaleKeys.notFound_notification.tr()),
        loadingBuilder: (context) => const PlaceShimmerList(),
        itemBuilder: (context, doc) {
          final model = doc.data();
          if (model == null || model.id.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: V2NotificationTile(
              model: model,
              onTap: () => navigateToDetail(model),
            ),
          );
        },
      ),
    );
  }
}

final class _Loading extends StatelessWidget {
  const _Loading({required this.loadingNotifier});

  final ValueNotifier<bool> loadingNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: loadingNotifier,
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      builder: (BuildContext context, bool value, Widget? child) {
        if (!value) return const SizedBox.shrink();
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
