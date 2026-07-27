import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum MerchantApplicationStep {
  company,
  media,
  owner;

  String get titleKey => switch (this) {
    MerchantApplicationStep.company =>
      LocaleKeys.merchantApplication_steps_company,
    MerchantApplicationStep.media => LocaleKeys.merchantApplication_steps_media,
    MerchantApplicationStep.owner => LocaleKeys.merchantApplication_steps_owner,
  };

  MerchantApplicationStep? get next =>
      index + 1 < values.length ? values[index + 1] : null;

  MerchantApplicationStep? get previous => index > 0 ? values[index - 1] : null;
}
