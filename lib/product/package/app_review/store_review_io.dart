import 'package:in_app_review/in_app_review.dart';
import 'package:lifeclient/product/package/app_review/store_review.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

final class PlatformStoreReview implements StoreReview {
  const PlatformStoreReview();

  @override
  bool get isSupported => true;

  @override
  Future<void> openStoreListing() => InAppReview.instance.openStoreListing(
    appStoreId: AppConstants.appStoreId,
  );
}
