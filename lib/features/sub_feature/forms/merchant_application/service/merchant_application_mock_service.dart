import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/service/merchant_application_service.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

final class MerchantApplicationMockService
    implements MerchantApplicationService {
  static bool _hasSubmittedInSession = false;

  @override
  Future<bool> submit(MerchantApplicationModel model) async {
    await Future<void>.delayed(DurationConstant.durationLow);
    _hasSubmittedInSession = true;
    return true;
  }

  @override
  Future<bool> hasActiveApplication() async {
    await Future<void>.delayed(DurationConstant.durationLow);
    return _hasSubmittedInSession;
  }
}
