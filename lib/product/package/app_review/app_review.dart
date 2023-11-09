import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

@immutable
final class AppReview {
  const AppReview._init();
  static const AppReview _instance = AppReview._init();
  static AppReview get instance => _instance;

  Future<void> openStore() async {
    final inAppReview = InAppReview.instance;
    await inAppReview.openStoreListing(
      appStoreId: AppConstants.appStoreId,
    );
  }
}
