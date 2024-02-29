import 'package:flutter/widgets.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/model/enum/notification_type.dart';
import 'package:lifeclient/product/package/firebase/messaging_navigate.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';

final class NotificationNavigateParse with NotificationTypeMixin {
  NotificationNavigateParse(this.context);
  final _customService = FirebaseCustomService();
  final BuildContext context;
  Future<void> _make(String id, NotificationType type) async {
    switch (type) {
      case NotificationType.project:
        await MessagingNavigate.instance.detailModelCheckAndNavigate(
          context: context,
          id: id,
        );
        return;
      case NotificationType.campaigns:
        if (!context.mounted) return;
        await MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
          context: context,
          id: id,
          customService: _customService,
        );
        return;

      case NotificationType.news:
        if (!context.mounted) return;
        await MessagingNavigate.instance.detailModelNewsCheckAndNavigate(
          context: context,
          id: id,
          customService: _customService,
        );
        return;
      case NotificationType.advertise:
        if (!context.mounted) return;
        await MessagingNavigate.instance
            .detailModelAdvertiseCheckAndShowBottomSheet(
          context: context,
          id: id,
          customService: _customService,
        );
        return;
      case NotificationType.link:
        //TODO: add code here
        return;
    }
  }

  Future<void> makeWithType({
    required NotificationType type,
    required String id,
  }) async {
    await _make(id, type);
  }

  Future<void> makeWithModel({
    required NotificationModel model,
  }) async {
    final (type, id) = modelConvertToType(model);
    if (type == null) return;
    await _make(id, type);
  }
}
