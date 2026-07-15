part of '../merchant_application_view.dart';

const int _maxPhotoCount = 10;
const int _photosPerRow = 4;

mixin _MerchantMediaStepMixin
    on
        StepFormConsumerState<_MerchantMediaStep>,
        AppProviderMixin<_MerchantMediaStep> {
  final TimePickerController openTimeController = TimePickerController();
  final TimePickerController closeTimeController = TimePickerController();
  final TextEditingController addressController = TextEditingController();

  LatLng? _selectedLocation;
  LatLng? get selectedLocation => _selectedLocation;

  String get companyAddress => addressController.text;

  final List<File> _photoFiles = [];
  List<File> get photoFiles => List.of(_photoFiles);

  int get _visiblePhotoSlotCount => _photoFiles.length < _maxPhotoCount
      ? _photoFiles.length + 1
      : _maxPhotoCount;

  OpenAndCloseTimeValidationModel get timeValidationModel =>
      OpenAndCloseTimeValidationModel(
        openTime: openTimeController.time,
        closeTime: closeTimeController.time,
      );

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
      (previous, next) => setState(() {
        next == null ? _clearCompanyAutofill() : _fillFromCompany(next);
      }),
    );
  }

  @override
  bool get isHasAnyData =>
      openTimeController.isValid ||
      closeTimeController.isValid ||
      addressController.text.isNotEmpty ||
      _photoFiles.isNotEmpty ||
      _selectedLocation != null;

  @override
  bool validateAndSave() {
    if (!super.validateAndSave()) return false;
    if (_photoFiles.isEmpty) {
      appProvider.showSnackbarMessage(
        LocaleKeys.validation_photoRequired.tr(),
      );
      return false;
    }
    return true;
  }

  void _clearCompanyAutofill() {
    openTimeController.reset();
    closeTimeController.reset();
    addressController.clear();
    _selectedLocation = null;
  }

  void _fillFromCompany(StoreModel? store) {
    if (store == null) return;
    final address = store.address;
    if (address != null && address.isNotEmpty) {
      addressController.text = address;
    }
    final openTime = store.openTime;
    if (openTime != null) openTimeController.text = openTime;
    final closeTime = store.closeTime;
    if (closeTime != null) closeTimeController.text = closeTime;
    final latLong = store.latLong;
    if (latLong != null) {
      _selectedLocation = LatLng(latLong.latitude, latLong.longitude);
    }
  }

  void _onLocationChanged(LatLng value) {
    _selectedLocation = value;
  }

  Future<void> _onPhotoSlotTapped(int index) async {
    final file = await GeneralMediaSheet.open(context);
    if (!mounted || file == null) return;
    setState(() {
      if (index < _photoFiles.length) {
        _photoFiles[index] = file;
      } else {
        _photoFiles.add(file);
      }
    });
  }

  void _removePhotoAt(int index) {
    if (index >= _photoFiles.length) return;
    _photoFiles.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }
}
