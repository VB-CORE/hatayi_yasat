enum MerchantShowcaseType {
  campaign('campaign'),
  announcement('announcement'),
  event('event')
  ;

  const MerchantShowcaseType(this.value);

  final String value;

  static MerchantShowcaseType fromValue(String? value) =>
      MerchantShowcaseType.values.firstWhere(
        (type) => type.value == value,
        orElse: () => MerchantShowcaseType.campaign,
      );
}
