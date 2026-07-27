import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum MerchantStepError {
  form,
  companyNotSelected,
  categoryEmpty,
  photoRequired,
  kvkkRequired,
  documentRequired;

  String? get messageKey => switch (this) {
    MerchantStepError.form => null,
    MerchantStepError.companyNotSelected =>
      LocaleKeys.merchantApplication_selectCompany,
    MerchantStepError.categoryEmpty => LocaleKeys.validation_categoryEmpty,
    MerchantStepError.photoRequired => LocaleKeys.validation_photoRequired,
    MerchantStepError.kvkkRequired => LocaleKeys.validation_kvkk,
    MerchantStepError.documentRequired =>
      LocaleKeys.merchantApplication_documentHint,
  };
}
