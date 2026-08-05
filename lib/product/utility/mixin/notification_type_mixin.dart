import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/notification_type.dart';

mixin NotificationTypeMixin {
  (NotificationType?, String) modelConvertToType(
    NotificationModel model,
  ) {
    if (model.link.ext.isNotNullOrNoEmpty && model.id.ext.isNotNullOrNoEmpty) {
      return (NotificationType.link, model.id!);
    }

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

    if (model.memoryId.ext.isNotNullOrNoEmpty) {
      return (NotificationType.memory, model.memoryId!);
    }

    return (null, '');
  }
}
