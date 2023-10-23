import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/package/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/widget/notifier/loading_notifier.dart';

mixin NotificationMixin
    on LoadingNotifier<NotificationsView>, State<NotificationsView> {
  final CustomService _customService = FirebaseService();

  CustomService get customService => _customService;
  late final DateTime? lastNotificationSeenTime;

  @override
  void initState() {
    super.initState();
    _saveAndLastTime();
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
    if (loadingNotifier.value) return;

    showLoading();

    switch (model.type) {
      case AppNotificationType.store:
        if (!mounted) return;
        await MessagingNavigate.instance.detailModelCheckAndNavigate(
          context: context,
          id: model.id,
          customService: customService,
        );
      case AppNotificationType.campaign:
        if (!mounted) return;
        await MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
          context: context,
          id: model.id,
          customService: customService,
        );
      case AppNotificationType.news:
        if (!mounted) return;
        await MessagingNavigate.instance.detailModelNewsCheckAndNavigate(
          context: context,
          id: model.id,
          customService: customService,
        );
      case AppNotificationType.advertise:
        if (!mounted) return;
        await MessagingNavigate.instance
            .detailModelAdvertiseCheckAndShowBottomSheet(
          context: context,
          id: model.id,
          customService: customService,
        );
      case null:
    }

    hideLoading();
  }

  void _saveAndLastTime() {
    lastNotificationSeenTime =
        SharedCache.instance.getLastNotificationSeenTime();
    SharedCache.instance.updateNotificationLastSeenTime();
  }
}
