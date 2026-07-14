part of '../merchant_application_view.dart';

const int _maxPhotoCount = 5;

mixin _MerchantCompanyStepMixin
    on
        RequestFormConsumerState<_MerchantCompanyStep>,
        AppProviderMixin<_MerchantCompanyStep> {
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeDescriptionController =
      TextEditingController();
  final TimePickerController openTimeController = TimePickerController();
  final TimePickerController closeTimeController = TimePickerController();
  final List<File> _photoFiles = [];
  bool _isNewCompanyMode = false;
  _CompanyDropdownItem? _selectedCompany;
  late final List<CategoryModel> categoryModels;
  late final List<RegionalCityModel> regionalCityModels;
  late final List<RegionalTownModel> _regionalTownModels;
  late RegionalCityModel _selectedRegionalCityModel;
  late RegionalTownModel _selectedRegionalTownModel;
  RegionalTownSubItem? _selectedRegionalTownSubItem;
  CategoryModel? _selectedCategory;

  RegionalCityModel get selectedRegionalCityModel => _selectedRegionalCityModel;
  RegionalTownModel get selectedRegionalTownModel => _selectedRegionalTownModel;
  RegionalTownSubItem? get selectedRegionalTownSubItem =>
      _selectedRegionalTownSubItem;

  @override
  void initState() {
    super.initState();
    categoryModels = productState.categoryItems;
    regionalCityModels = productState.regionalCityItems;
    _regionalTownModels = productState.regionalTownItems;
    _selectedRegionalCityModel = productState.selectedCity;
    _updateRegionalTown();
  }

  @override
  bool get isHasAnyData =>
      placeNameController.text.isNotEmpty ||
      placeDescriptionController.text.isNotEmpty ||
      openTimeController.isValid ||
      closeTimeController.isValid ||
      _photoFiles.isNotEmpty ||
      _selectedCompany != null ||
      _selectedCategory != null;

  @override
  bool validateAndSave() {
    if (!super.validateAndSave()) return false;
    if (!_isNewCompanyMode && _selectedCompany == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.merchantApplication_selectCompany.tr(),
      );
      return false;
    }
    if (_selectedCategory == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.validation_categoryEmpty.tr(),
      );
      return false;
    }
    return true;
  }

  String get companyName => placeNameController.text;
  String get companyDescription => placeDescriptionController.text;
  CategoryModel? get selectedCategory => _selectedCategory;
  TownModel? get selectedDistrict => _selectedRegionalTownSubItem?.toTownModel;
  String get selectedCityId => _selectedRegionalCityModel.documentId;
  List<File> get photoFiles => List.of(_photoFiles);
  OpenAndCloseTimeValidationModel get timeValidationModel =>
      OpenAndCloseTimeValidationModel(
        openTime: openTimeController.time,
        closeTime: closeTimeController.time,
      );

  void toggleCompanyMode({required bool isNew}) {
    if (_isNewCompanyMode == isNew) return;
    _isNewCompanyMode = isNew;
    setState(() {});
  }

  void onCompanySelected(_CompanyDropdownItem item) {
    _selectedCompany = item;
    _fillFromCompany(item.store);
    setState(() {});
  }

  void _fillFromCompany(StoreModel store) {
    placeNameController.text = store.name;
    placeDescriptionController.text = store.description ?? '';
    final openTime = store.openTime;
    if (openTime != null) openTimeController.text = openTime;
    final closeTime = store.closeTime;
    if (closeTime != null) closeTimeController.text = closeTime;
    for (final category in categoryModels) {
      if (category.value == store.category?.value) {
        _selectedCategory = category;
        break;
      }
    }
    if (store.cityId.isNotEmpty) {
      for (final city in regionalCityModels) {
        if (city.documentId == store.cityId) {
          _selectedRegionalCityModel = city;
          _updateRegionalTown();
          break;
        }
      }
    }
    for (final town in _selectedRegionalTownModel.towns) {
      if (town.code == store.townCode) {
        _selectedRegionalTownSubItem = town;
        break;
      }
    }
  }

  void _updateRegionalTown() {
    _selectedRegionalTownModel = _regionalTownModels.firstWhere(
      (element) => element.cityId == _selectedRegionalCityModel.documentId,
    );
    _selectedRegionalTownSubItem = _selectedRegionalTownModel.towns.first;
  }

  void updateRegionalCityItem(RegionalCityModel item) {
    _selectedRegionalCityModel = item;
    _updateRegionalTown();
    setState(() {});
  }

  void updateRegionalTownItem(RegionalTownSubItem item) {
    _selectedRegionalTownSubItem = item;
  }

  void _onCategorySelected(CategoryModel category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    setState(() {});
  }

  Future<void> _onPhotoSlotTapped(int index) async {
    final file = await GeneralMediaSheet.open(context);
    if (file == null) return;
    setState(() {
      if (index < _photoFiles.length) {
        _photoFiles[index] = file;
      } else {
        _photoFiles.add(file);
      }
    });
  }

  void _onPhotoRemoved(int index) {
    if (index >= _photoFiles.length) return;
    _photoFiles.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    placeNameController.dispose();
    placeDescriptionController.dispose();
  }
}
