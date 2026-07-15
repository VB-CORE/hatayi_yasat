import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/service/merchant_application_service.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

final class MerchantApplicationMockService
    implements MerchantApplicationService {
  static final List<StoreModel> _companies = [
    _company(
      name: 'Künefeci Saim Usta',
      owner: 'Saim Usta',
      description:
          'Uzun Çarşı girişinde üçüncü kuşak künefeci. Odun ateşinde, '
          'Hatay peyniriyle klasik ve fıstıklı künefe.',
      address: 'Uzun Çarşı Cd. No:12, Antakya',
      phone: '5301112233',
      category: const CategoryModel(name: 'Yemek', value: 1),
      townCode: 31,
      openTime: '09:00',
      closeTime: '22:00',
      visitCount: 1250,
      latitude: 36.2025,
      longitude: 36.1606,
    ),
    _company(
      name: 'Affan Kahvecisi',
      owner: 'Mehmet Affan',
      description:
          '1911’den beri haytalı ve mırra ile hizmet veren tarihi kahvehane.',
      address: 'Hürriyet Cd. No:5, Antakya',
      phone: '5302223344',
      category: const CategoryModel(name: 'Kafe', value: 2),
      townCode: 31,
      openTime: '08:00',
      closeTime: '23:00',
      visitCount: 3400,
      latitude: 36.2031,
      longitude: 36.1592,
    ),
    _company(
      name: 'Sveyka Restoran',
      owner: 'Selin Karaca',
      description:
          'Taş konakta Hatay mutfağı: tuzlu yoğurt çorbası, kağıt kebabı ve '
          'zahter salatası.',
      address: 'Kurtuluş Cd. No:41, Antakya',
      phone: '5303334455',
      category: const CategoryModel(name: 'Yemek', value: 1),
      townCode: 31,
      openTime: '11:00',
      closeTime: '00:00',
      visitCount: 890,
      latitude: 36.2010,
      longitude: 36.1633,
    ),
    _company(
      name: 'Hatay Simit Sarayı',
      owner: 'Hasan Demir',
      description:
          'Sabah 6’dan itibaren taş fırından sıcak simit, biberli ekmek ve '
          'kömbe.',
      address: 'Atatürk Cd. No:88, İskenderun',
      phone: '5304445566',
      category: const CategoryModel(name: 'EĞİTİM', value: 3),
      townCode: 32,
      openTime: '06:00',
      closeTime: '20:00',
      visitCount: 2100,
      latitude: 36.5872,
      longitude: 36.1735,
    ),
  ];

  static StoreModel _company({
    required String name,
    required String owner,
    required String description,
    required String address,
    required String phone,
    required CategoryModel category,
    required int townCode,
    required String openTime,
    required String closeTime,
    required int visitCount,
    required double latitude,
    required double longitude,
  }) => StoreModel(
    name: name,
    owner: owner,
    description: description,
    address: address,
    phone: phone,
    images: const [
      'https://picsum.photos/seed/hatay/600/400',
    ],
    category: category,
    townCode: townCode,
    openTime: openTime,
    closeTime: closeTime,
    visitCount: visitCount,
    latLong: GeoPoint(latitude, longitude),
    cityId: 'hatay',
    deviceID: 'mock-device',
    createdAt: DateTime(2026, 5, 2, 14, 32),
    updatedAt: DateTime(2026, 5, 2, 14, 32),
    isApproved: true,
    documentId: name,
  );

  @override
  Future<List<StoreModel>> fetchCompanies() async {
    await Future<void>.delayed(DurationConstant.durationLow);
    return _companies;
  }

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
