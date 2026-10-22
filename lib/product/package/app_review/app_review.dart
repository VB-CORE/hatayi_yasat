import 'package:flutter/material.dart';
import 'package:lifeclient/product/package/app_review/store_review_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/package/app_review/store_review_web.dart';

@immutable
final class AppReview {
  const AppReview._init();
  static const AppReview _instance = AppReview._init();
  static AppReview get instance => _instance;

  bool get isSupported => const PlatformStoreReview().isSupported;

  Future<void> openStore() => const PlatformStoreReview().openStoreListing();
}
