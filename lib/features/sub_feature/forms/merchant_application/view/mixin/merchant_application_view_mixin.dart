part of '../merchant_application_view.dart';

mixin MerchantApplicationViewMixin
    on
        ConsumerState<MerchantApplicationView>,
        AppProviderMixin<MerchantApplicationView> {
  final PageController pageController = PageController();
  final GlobalKey<_MerchantCompanyStepState> _companyStepKey =
      GlobalKey<_MerchantCompanyStepState>();
  final GlobalKey<_MerchantMediaStepState> _mediaStepKey =
      GlobalKey<_MerchantMediaStepState>();
  final GlobalKey<_MerchantOwnerStepState> _ownerStepKey =
      GlobalKey<_MerchantOwnerStepState>();

  MerchantApplicationViewModel get viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(viewModel.loadCompanies));
    ref.listenManual(
      merchantApplicationViewModelProvider.select((value) => value.currentStep),
      onStepChanged,
    );
  }

  void onStepChanged(
    MerchantApplicationStep? previousStep,
    MerchantApplicationStep nextStep,
  ) {
    if (!pageController.hasClients) return;
    unawaited(
      pageController.animateToPage(
        nextStep.index,
        duration: DurationConstant.durationLow,
        curve: Curves.easeInOut,
      ),
    );
  }

  bool _validateCurrentStep(MerchantApplicationStep step) => switch (step) {
    MerchantApplicationStep.company =>
      _companyStepKey.currentState?.validateAndSave() ?? false,
    MerchantApplicationStep.media =>
      _mediaStepKey.currentState?.validateAndSave() ?? false,
    MerchantApplicationStep.owner =>
      _ownerStepKey.currentState?.validateAndSave() ?? false,
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

  void onBackPressed() => viewModel.previousStep();

  Future<void> _submit() async {
    final company = _companyStepKey.currentState;
    final media = _mediaStepKey.currentState;
    final owner = _ownerStepKey.currentState;
    if (company == null || media == null || owner == null) return;
    if (!company.validateAndSave()) {
      viewModel.goToStep(MerchantApplicationStep.company);
      return;
    }
    if (!media.validateAndSave()) {
      viewModel.goToStep(MerchantApplicationStep.media);
      return;
    }
    if (!owner.validateAndSave()) return;

    final model = _buildModel(company: company, media: media, owner: owner);
    if (model == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    final isSuccess = await viewModel.submit(model);
    await _onSubmitResult(isSuccess: isSuccess);
  }

  MerchantApplicationModel? _buildModel({
    required _MerchantCompanyStepState company,
    required _MerchantMediaStepState media,
    required _MerchantOwnerStepState owner,
  }) {
    final category = company.selectedCategory;
    final district = company.selectedDistrict;
    final documentFile = owner.documentFile;
    final location = media.selectedLocation;
    if (category == null || district == null) return null;
    if (documentFile == null || location == null) return null;

    return MerchantApplicationModel(
      placeName: company.companyName,
      placeDescription: company.companyDescription,
      placeAddress: media.companyAddress,
      placeOwnerName: owner.ownerName,
      placePhoneNumber: owner.phoneNumber,
      placeCategory: category,
      placeDistrict: district,
      photoFiles: media.photoFiles,
      documentFile: documentFile,
      timeValidationModel: media.timeValidationModel,
      selectedLocation: location,
      selectedCityId: company.selectedCityId,
      isComment: owner.isCommentEnabled,
    );
  }

  Future<void> _onSubmitResult({required bool isSuccess}) async {
    if (!mounted) return;
    if (!isSuccess) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    appProvider.showSnackbarMessage(
      LocaleKeys.merchantApplication_status_submitted.tr(),
    );
    const MerchantApplicationStatusRoute().pushReplacement(context);
  }

  void onPopInvoked(bool didPop, Object? result) {
    if (didPop) return;
    unawaited(_confirmAndClose());
  }

  Future<void> _confirmAndClose() async {
    final response = await FormLatestDataDialog.show(context);
    if (!response || !mounted) return;
    context.pop();
  }

  void onClosePressed() => unawaited(_confirmAndClose());

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
