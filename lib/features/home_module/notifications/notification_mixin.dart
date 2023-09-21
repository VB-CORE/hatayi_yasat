import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';

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
      path: CollectionPaths.notifications,
    );
    _notificationNotifier.value = response;
  }
}
