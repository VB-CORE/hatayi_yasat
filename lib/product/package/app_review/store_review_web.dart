import 'package:lifeclient/product/package/app_review/store_review.dart';

final class PlatformStoreReview implements StoreReview {
  const PlatformStoreReview();

  @override
  bool get isSupported => false;

  @override
  Future<void> openStoreListing() async {}
}
