import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/notification_type.dart';

NotificationType fromAppNotifications(AppNotificationType type) =>
    switch (type) {
      AppNotificationType.place ||
      AppNotificationType.store => NotificationType.project,
      AppNotificationType.event ||
      AppNotificationType.campaign => NotificationType.campaigns,
      AppNotificationType.memory => NotificationType.memory,
      AppNotificationType.news => NotificationType.news,
      AppNotificationType.advertise => NotificationType.advertise,
      AppNotificationType.link => NotificationType.link,
      AppNotificationType.system => throw ArgumentError.value(
        type,
        'type',
        'AppNotificationType.system has no navigation target',
      ),
    };
