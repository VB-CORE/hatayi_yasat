import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/service/custom_service.dart';
import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

@immutable
final class MessagingNavigate {
  const MessagingNavigate._();
  static MessagingNavigate instance = const MessagingNavigate._();
  Future<void> navigateDetailNotification({
    required BuildContext context,
    required String id,
    required CustomService customService,
  }) async {
    final data = await customService.getSingleData(
      model: StoreModel.empty(),
      path: CollectionEnums.approvedApplications,
      id: id,
    );

    if (data == null) return;
    if (!context.mounted) return;
    await context.route.navigateToPage(HomeDetailView(model: data));
  }
}
