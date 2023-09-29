import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home/view/home_view.dart';
import 'package:vbaseproject/product/model/enum/notification_type.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_utility.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';

mixin HomeNotificationMixin
    on AppProviderMixin<HomeView>, ConsumerState<HomeView> {
  final _customService = FirebaseService();
  Future<void> listenToNotification() async {
    final initialNotification = await MessagingUtility.getInitialData();
    if (initialNotification != null) {
      await _navigateToDetail(initialNotification);
    }
    MessagingUtility.listenData(
      onMessageHandle: _navigateToDetail,
      onMessageHandleInApp: _openSnackbarMessage,
    );
  }

  Future<void> _navigateToDetail(NotificationModel model) async {
    final id = model.id;
    final campaignId = model.campaignId;

    if (id != null && id.isNotEmpty) {
      await MessagingNavigate.instance.detailModelCheckAndNavigate(
        context: context,
        id: id,
        customService: _customService,
      );
      return;
    }

    if (campaignId != null && campaignId.isNotEmpty) {
      await MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
        context: context,
        id: campaignId,
        customService: _customService,
      );
      return;
    }
  }

  Future<void> _openSnackbarMessage(
    MapEntry<String, NotificationModel> model,
  ) async {
    final id = model.value.id;
    final campaignId = model.value.campaignId;

    if (id != null && id.isNotEmpty) {
      appProvider.showSnackbarNotification(
        model.key,
        id,
        context,
        NotificationType.project,
      );
      return;
    }

    if (campaignId != null && campaignId.isNotEmpty) {
      appProvider.showSnackbarNotification(
        model.key,
        campaignId,
        context,
        NotificationType.campaigns,
      );
      return;
    }
  }
}
