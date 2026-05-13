import 'package:lifeclient/product/repository/merchant/merchant_application_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_application_repository_provider.g.dart';

@Riverpod(keepAlive: true)
MerchantApplicationRepository merchantApplicationRepository(Ref ref) =>
    MerchantApplicationRepository();
