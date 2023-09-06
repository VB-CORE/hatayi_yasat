import 'package:flutter/material.dart';
import 'package:vbaseproject/features/home_module/notifications/notificaitons_view.dart';
import 'package:vbaseproject/product/model/firebase/app_notification_model.dart';
import 'package:vbaseproject/product/service/custom_service.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

mixin NotificationMixin on State<NotificationsView> {
  final _notificationNotifier = ValueNotifier<List<AppNotificationModel>>([]);
  final CustomService _customService = FirebaseService();

  ValueNotifier<List<AppNotificationModel>> get notificationNotifier =>
      _notificationNotifier;

  CustomService get customService => _customService;
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await _customService.getList<AppNotificationModel>(
      model: AppNotificationModel(),
      path: CollectionEnums.notifications,
    );
    _notificationNotifier.value = response;
  }
}
