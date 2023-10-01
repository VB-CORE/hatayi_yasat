import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/notifier/loading_notifier.dart';

mixin NotificationMixin
    on LoadingNotifier<NotificationsView>, State<NotificationsView> {
  final CustomService _customService = FirebaseService();

  CustomService get customService => _customService;

  CollectionReference<AppNotificationModel?> reference() {
    return _customService.collectionReference(
      CollectionPaths.notifications,
      AppNotificationModel(),
    );
  }

  Future<void> navigateToDetail(AppNotificationModel? model) async {
    if (model == null) return;
    if (loadingNotifier.value) return;

    showLoading();
    if (model.type == AppNotificationType.campaign) {
      await MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
        context: context,
        id: model.id,
        customService: customService,
      );
    } else {
      await MessagingNavigate.instance.detailModelCheckAndNavigate(
        context: context,
        id: model.id,
        customService: customService,
      );
    }

    hideLoading();
  }
}
