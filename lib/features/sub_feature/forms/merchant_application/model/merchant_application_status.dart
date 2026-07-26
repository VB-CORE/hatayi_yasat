enum MerchantApplicationStatus {
  pending(1),
  approved(2),
  denied(3);

  const MerchantApplicationStatus(this.value);

  final int value;

  static MerchantApplicationStatus fromValue(int? value) =>
      MerchantApplicationStatus.values.firstWhere(
        (status) => status.value == value,
        orElse: () => MerchantApplicationStatus.pending,
      );
}
