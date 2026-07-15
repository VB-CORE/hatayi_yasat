import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';

abstract interface class MerchantApplicationService {
  Future<List<StoreModel>> fetchCompanies();
  Future<bool> submit(MerchantApplicationModel model);
  Future<bool> hasActiveApplication();
}
