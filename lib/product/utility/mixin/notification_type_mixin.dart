import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/notification_type.dart';

mixin NotificationTypeMixin {
  (NotificationType?, String) modelConvertToType(
    NotificationModel model,
  ) {
    if (model.id.ext.isNotNullOrNoEmpty) {
      return (NotificationType.project, model.id!);
    }

    if (model.campaignId.ext.isNotNullOrNoEmpty) {
      return (NotificationType.campaigns, model.campaignId!);
    }

    if (model.newsId.ext.isNotNullOrNoEmpty) {
      return (NotificationType.news, model.newsId!);
    }

    if (model.advertiseId.ext.isNotNullOrNoEmpty) {
      return (NotificationType.advertise, model.advertiseId!);
    }

    return (null, '');
  }

  NotificationType fromAppNotifications(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.store:
        return NotificationType.project;
      case AppNotificationType.campaign:
        return NotificationType.campaigns;
      case AppNotificationType.news:
        return NotificationType.news;
      case AppNotificationType.advertise:
        return NotificationType.advertise;
      case AppNotificationType.link:
        throw UnimplementedError();
    }
  }
}
