part of '../merchant_application_view.dart';

mixin _MerchantOwnerStepMixin
    on
        RequestFormConsumerState<_MerchantOwnerStep>,
        AppProviderMixin<_MerchantOwnerStep> {
  final TextEditingController placeOwnerNameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isCommentEnabled = true;
  bool _isKVKKChecked = false;
  File? _documentFile;
  LatLng? _selectedLocation;

  bool get isKVKKChecked => _isKVKKChecked;
  File? get documentFile => _documentFile;
  LatLng? get selectedLocation => _selectedLocation;
  bool get isCommentEnabled => _isCommentEnabled;

  @override
  bool get isHasAnyData =>
      placeOwnerNameController.text.isNotEmpty ||
      phoneNumberController.text.isNotEmpty ||
      _isKVKKChecked ||
      _documentFile != null ||
      _selectedLocation != null;

  void _onCommentToggleChanged(bool value) {
    _isCommentEnabled = value;
    setState(() {});
  }

  void updateKVKK({required bool value}) {
    _isKVKKChecked = value;
  }

  void updateSelectedLocation(LatLng value) {
    _selectedLocation = value;
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
    if (!super.validateAndSave()) return false;
    if (_documentFile == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.merchantApplication_documentHint.tr(),
      );
      return false;
    }
    return true;
  }

  String get ownerName => placeOwnerNameController.text;
  String get phoneNumber => phoneNumberController.text;

  @override
  void dispose() {
    super.dispose();
    placeOwnerNameController.dispose();
    phoneNumberController.dispose();
  }
}
