import 'package:lifeclient/features/sub_feature/forms/merchant_application/service/merchant_application_mock_service.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/service/merchant_application_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_application_service_provider.g.dart';

@riverpod
MerchantApplicationService merchantApplicationService(Ref ref) =>
    MerchantApplicationMockService();
