import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaign_details/campaign_details_view.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

import 'package:vbaseproject/product/widget/snackbar/error_snack_bar.dart';

@immutable
final class MessagingNavigate {
  const MessagingNavigate._();
  static MessagingNavigate instance = const MessagingNavigate._();
  Future<StoreModel?> _getDetailModelFromNotification({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final data = await customService.getSingleData(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: id,
    );

    return data;
  }

  Future<CampaignModel?> _getDetailModelFromCampaign({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final data = await customService.getSingleData(
      model: CampaignModel(),
      path: CollectionPaths.approvedCampaigns,
      id: id,
    );

    return data;
  }

  Future<void> detailModelCheckAndNavigate({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final result = await _getDetailModelFromNotification(
      context: context,
      id: id,
      customService: customService,
    );
    if (!context.mounted) return;
    if (result != null) {
      await context.route.navigateToPage(HomeDetailView(model: result));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          message:
              LocaleKeys.notification_business_not_found_error_message.tr(),
        ),
      );
    }
  }

  Future<void> detailModelCampaignCheckAndNavigate({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final result = await _getDetailModelFromCampaign(
      context: context,
      id: id,
      customService: customService,
    );
    if (!context.mounted) return;
    if (result != null) {
      await context.route
          .navigateToPage(CampaignDetailsView(campaignModel: result));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          message:
              LocaleKeys.notification_campaign_not_found_error_message.tr(),
        ),
      );
    }
  }
}
