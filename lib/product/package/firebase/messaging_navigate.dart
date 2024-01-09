import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/event_detail_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:vbaseproject/product/widget/sheet/advertise_sheet.dart';
import 'package:vbaseproject/product/widget/snackbar/error_snack_bar.dart';

@immutable
final class MessagingNavigate {
  const MessagingNavigate._();
  static MessagingNavigate instance = const MessagingNavigate._();

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

  Future<NewsModel?> _getDetailModelFromNews({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final data = await customService.getSingleData(
      model: NewsModel(),
      path: CollectionPaths.news,
      id: id,
    );

    return data;
  }

  Future<AdvertiseModel?> _getDetailModelFromAdvertise({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final data = await customService.getSingleData(
      model: AdvertiseModel(),
      path: CollectionPaths.approvedAdvertise,
      id: id,
    );

    return data;
  }

  Future<void> detailModelCheckAndNavigate({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    PlaceDetailRoute($extra: StoreModel.empty(), id: id).go(context);
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
      await context.route.navigateToPage(EventDetailView(event: result));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          message: LocaleKeys.notification_campaignNotFoundErrorMessage.tr(),
        ),
      );
    }
  }

  Future<void> detailModelNewsCheckAndNavigate({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final result = await _getDetailModelFromNews(
      context: context,
      id: id,
      customService: customService,
    );
    if (!context.mounted) return;
    if (result != null) {
      NewsDetailRoute($extra: result).go(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          message: LocaleKeys.notification_newsNotFoundErrorMessage.tr(),
        ),
      );
    }
  }

  Future<void> detailModelAdvertiseCheckAndShowBottomSheet({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final result = await _getDetailModelFromAdvertise(
      context: context,
      id: id,
      customService: customService,
    );
    if (!context.mounted) return;
    if (result != null) {
      await AdvertiseSheet.show(context, item: result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          message: LocaleKeys.notification_advertiseNotFoundErrorMessage.tr(),
        ),
      );
    }
  }
}
