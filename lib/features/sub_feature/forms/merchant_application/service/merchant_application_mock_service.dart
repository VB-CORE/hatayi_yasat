import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/service/merchant_application_service.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

final class MerchantApplicationMockService
    implements MerchantApplicationService {
  static final List<StoreModel> _companies = [
    _company('Künefeci Saim Usta'),
    _company('Affan Kahvecisi'),
    _company('Sveyka Restoran'),
    _company('Hatay Simit Sarayı'),
  ];

  static StoreModel _company(String name) => StoreModel(
    name: name,
    owner: '',
    address: 'Antakya',
    phone: '',
    images: const [],
    townCode: 0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
    isApproved: true,
    documentId: name,
  );

  @override
  Future<List<StoreModel>> fetchCompanies() async {
    await Future<void>.delayed(DurationConstant.durationLow);
    return _companies;
  }

  @override
  Future<bool> submit(MerchantApplicationModel model) async {
    await Future<void>.delayed(DurationConstant.durationLow);
    return true;
  }
}
