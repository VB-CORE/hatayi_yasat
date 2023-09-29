import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';

mixin NotificationMixin on State<NotificationsView> {
  final CustomService _customService = FirebaseService();

  CustomService get customService => _customService;

  CollectionReference<AppNotificationModel?> reference() {
    return _customService.collectionReference(
      CollectionPaths.notifications,
      AppNotificationModel(),
    );
  }
}
