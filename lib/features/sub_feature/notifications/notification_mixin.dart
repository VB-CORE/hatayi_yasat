import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/notifications_view.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/notifier/loading_notifier.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin NotificationMixin
    on
        LoadingNotifier<NotificationsView>,
        State<NotificationsView>,
        NotificationTypeMixin {
  final CustomService _customService = FirebaseService();

  CustomService get customService => _customService;
  late final DateTime? lastNotificationSeenTime;

  @override
  void initState() {
    super.initState();
  }

  Query<AppNotificationModel?> reference() {
    return _customService
        .collectionReference(
          CollectionPaths.notifications,
          AppNotificationModel(),
        )
        .orderBy(
          QueryOrders.createdAt.name,
          descending: true,
        );
  }

  Future<void> navigateToDetail(AppNotificationModel? model) async {
    if (model == null) return;
    if (model.type == null) return;
    if (loadingNotifier.value) return;

    showLoading();

    await NotificationNavigateParse(context).makeWithType(
      id: model.id,
      type: fromAppNotifications(model.type!),
    );

    hideLoading();
  }

  /// TODO: This method is not working properly.
  /// Need to fixed new release
  // void _saveAndLastTime() {
  //   lastNotificationSeenTime =
  //       SharedCache.instance.getLastNotificationSeenTime();
  //   SharedCache.instance.updateNotificationLastSeenTime();
  // }
}
