part of '../merchant_application_view.dart';

mixin MerchantApplicationViewMixin
    on
        ConsumerState<MerchantApplicationView>,
        AppProviderMixin<MerchantApplicationView> {
  final PageController pageController = PageController();

  final GlobalKey<FormState> companyFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mediaFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> ownerFormKey = GlobalKey<FormState>();

  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeDescriptionController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TimePickerController openTimeController = TimePickerController();
  final TimePickerController closeTimeController = TimePickerController();
  final TextEditingController placeOwnerNameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKeyFor(MerchantApplicationStep step) =>
      switch (step) {
        MerchantApplicationStep.company => companyFormKey,
        MerchantApplicationStep.media => mediaFormKey,
        MerchantApplicationStep.owner => ownerFormKey,
      };

  MerchantApplicationViewModel get viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    ref
      ..listenManual(
        merchantApplicationViewModelProvider.select(
          (value) => value.currentStep,
        ),
        _onStepChanged,
      )
      ..listenManual(
        merchantApplicationViewModelProvider.select(
          (value) => value.selectedCompany,
        ),
        (previous, next) {
          next == null
              ? _clearCompanyControllers()
              : _fillControllersFromStore(next);
        },
      );
  }

  @override
  void dispose() {
    pageController.dispose();
    placeNameController.dispose();
    placeDescriptionController.dispose();
    addressController.dispose();
    openTimeController.dispose();
    closeTimeController.dispose();
    placeOwnerNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _onStepChanged(
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

  void onNextPressed() {
    final state = ref.read(merchantApplicationViewModelProvider);
    if (state.isLastStep) {
      unawaited(_submit());
      return;
    }
    if (!_validateStep(state.currentStep)) return;
    viewModel.nextStep();
  }

  void onBackPressed() => viewModel.previousStep();

  bool _validateStep(MerchantApplicationStep step) {
    final isFormValid = _formKeyFor(step).currentState?.validate() ?? false;
    _flushAll();
    final error = viewModel.validateStep(step, isFormValid: isFormValid);
    if (error == null) return true;
    final message = error.messageKey;
    if (message != null) appProvider.showSnackbarMessage(message.tr());
    return false;
  }

  void _flushAll() {
    viewModel
      ..setCompanyText(
        name: placeNameController.text,
        description: placeDescriptionController.text,
      )
      ..setMediaText(
        address: addressController.text,
        openTime: openTimeController.time,
        closeTime: closeTimeController.time,
      )
      ..setOwnerText(
        name: placeOwnerNameController.text,
        phone: phoneNumberController.text,
      );
  }

  void _fillControllersFromStore(StoreModel store) {
    placeNameController.text = store.name;
    placeDescriptionController.text = store.description ?? '';
    if (store.owner.isNotEmpty) placeOwnerNameController.text = store.owner;
    if (store.phone.isNotEmpty) phoneNumberController.text = store.phone;
    final address = store.address;
    if (address != null && address.isNotEmpty) addressController.text = address;
    final openTime = store.openTime;
    if (openTime != null) openTimeController.text = openTime;
    final closeTime = store.closeTime;
    if (closeTime != null) closeTimeController.text = closeTime;
  }

  void _clearCompanyControllers() {
    placeNameController.clear();
    placeDescriptionController.clear();
    placeOwnerNameController.clear();
    phoneNumberController.clear();
    addressController.clear();
    openTimeController.reset();
    closeTimeController.reset();
  }

  Future<void> _submit() async {
    for (final step in MerchantApplicationStep.values) {
      if (!_validateStep(step)) {
        viewModel.goToStep(step);
        return;
      }
    }
    final isSuccess = await viewModel.submit();
    await _onSubmitResult(isSuccess: isSuccess);
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
}
