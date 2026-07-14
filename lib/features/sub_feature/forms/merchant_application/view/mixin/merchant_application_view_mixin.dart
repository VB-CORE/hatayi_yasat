part of '../merchant_application_view.dart';

mixin MerchantApplicationViewMixin
    on
        ConsumerState<MerchantApplicationView>,
        AppProviderMixin<MerchantApplicationView> {
  final PageController pageController = PageController();
  final GlobalKey<_MerchantCompanyStepState> companyStepKey =
      GlobalKey<_MerchantCompanyStepState>();
  final GlobalKey<_MerchantOwnerStepState> ownerStepKey =
      GlobalKey<_MerchantOwnerStepState>();

  MerchantApplicationViewModel get viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(viewModel.loadCompanies));
  }

  void onStepChanged(int? previousStep, int nextStep) {
    if (!pageController.hasClients) return;
    unawaited(
      pageController.animateToPage(
        nextStep,
        duration: DurationConstant.durationLow,
        curve: Curves.easeInOut,
      ),
    );
  }

  bool _validateCurrentStep(int step) => switch (step) {
    0 => companyStepKey.currentState?.validateAndSave() ?? false,
    _ => ownerStepKey.currentState?.validateAndSave() ?? false,
  };

  void onNextPressed() {
    final state = ref.read(merchantApplicationViewModelProvider);
    if (!_validateCurrentStep(state.currentStep)) return;
    if (state.isLastStep) {
      unawaited(_submit());
      return;
    }
    viewModel.nextStep();
  }

  Future<void> _submit() async {
    final company = companyStepKey.currentState;
    final owner = ownerStepKey.currentState;
    if (company == null || owner == null) return;
    if (!company.validateAndSave()) {
      viewModel.previousStep();
      return;
    }
    if (!owner.validateAndSave()) return;

    final category = company.selectedCategory;
    final district = company.selectedDistrict;
    final documentFile = owner.documentFile;
    final location = owner.selectedLocation;
    if (category == null || district == null) return;
    if (documentFile == null || location == null) return;

    final model = MerchantApplicationModel(
      placeName: company.companyName,
      placeDescription: company.companyDescription,
      placeOwnerName: owner.ownerName,
      placePhoneNumber: owner.phoneNumber,
      placeCategory: category,
      placeDistrict: district,
      photoFiles: company.photoFiles,
      documentFile: documentFile,
      timeValidationModel: company.timeValidationModel,
      selectedLocation: location,
      selectedCityId: company.selectedCityId,
      isComment: owner.isCommentEnabled,
    );
    final isOkay = await viewModel.submit(model);
    await _dataSendingComplete(isOkay: isOkay);
  }

  Future<void> _dataSendingComplete({required bool isOkay}) async {
    if (!mounted) return;
    if (!isOkay) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    const MerchantApplicationStatusRoute().pushReplacement(context);
  }

  void onBackPressed() => viewModel.previousStep();

  void onClosePressed() => context.pop();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
