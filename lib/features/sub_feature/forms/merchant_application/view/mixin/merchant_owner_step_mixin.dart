part of '../merchant_application_view.dart';

mixin _MerchantOwnerStepMixin
    on
        StepFormConsumerState<_MerchantOwnerStep>,
        AppProviderMixin<_MerchantOwnerStep> {
  final TextEditingController placeOwnerNameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isCommentEnabled = true;
  bool _isKVKKChecked = false;
  File? _documentFile;

  bool get isKVKKChecked => _isKVKKChecked;
  set isKVKKChecked(bool value) => _isKVKKChecked = value;
  File? get documentFile => _documentFile;
  bool get isCommentEnabled => _isCommentEnabled;
  String get ownerName => placeOwnerNameController.text;
  String get phoneNumber => phoneNumberController.text;

  @override
  void initState() {
    super.initState();
    _fillFromCompany(
      ref.read(merchantApplicationViewModelProvider).selectedCompany,
    );
    ref.listenManual(
      merchantApplicationViewModelProvider.select(
        (value) => value.selectedCompany,
      ),
      (previous, next) => setState(() => _fillFromCompany(next)),
    );
  }

  void _fillFromCompany(StoreModel? store) {
    if (store == null) return;
    if (store.owner.isNotEmpty) {
      placeOwnerNameController.text = store.owner;
    }
    if (store.phone.isNotEmpty) {
      phoneNumberController.text = store.phone;
    }
  }

  @override
  bool get isHasAnyData =>
      placeOwnerNameController.text.isNotEmpty ||
      phoneNumberController.text.isNotEmpty ||
      _isKVKKChecked ||
      _documentFile != null;

  void _onCommentToggleChanged(bool value) {
    _isCommentEnabled = value;
    setState(() {});
  }

  bool _validateDocumentSize(File file) {
    if (file.lengthSync() <= FileSizes.large.toByte) return true;
    appProvider.showSnackbarMessage(
      LocaleKeys.requestScholarship_error_fileSizeError.tr(),
    );
    return false;
  }

  void _onDocumentPicked(File file) {
    _documentFile = file;
  }

  @override
  bool validateAndSave() {
    if (!super.validateAndSave()) {
      if (!_isKVKKChecked) {
        appProvider.showSnackbarMessage(LocaleKeys.validation_kvkk.tr());
      }
      return false;
    }
    if (_documentFile == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.merchantApplication_documentHint.tr(),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    placeOwnerNameController.dispose();
    phoneNumberController.dispose();
  }
}
