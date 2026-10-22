abstract interface class StoreReview {
  bool get isSupported;

  Future<void> openStoreListing();
}
