part of '../merchant_application_view.dart';

mixin _MerchantCompanyStepMixin
    on
        StepFormConsumerState<_MerchantCompanyStep>,
        AppProviderMixin<_MerchantCompanyStep> {
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeDescriptionController =
      TextEditingController();

  late final List<CategoryModel> categoryModels;
  late final List<RegionalCityModel> regionalCityModels;
  late final List<RegionalTownModel> _regionalTownModels;

  late RegionalCityModel _selectedRegionalCityModel;
  late RegionalTownModel _selectedRegionalTownModel;

  RegionalTownSubItem? _selectedRegionalTownSubItem;
  CategoryModel? _selectedCategory;
  MerchantCompanyDropdownModel? _selectedCompany;
  bool _isNewCompanyMode = false;

  RegionalCityModel get selectedRegionalCityModel => _selectedRegionalCityModel;
  RegionalTownModel get selectedRegionalTownModel => _selectedRegionalTownModel;
  RegionalTownSubItem? get selectedRegionalTownSubItem =>
      _selectedRegionalTownSubItem;

  String get companyName => placeNameController.text;
  String get companyDescription => placeDescriptionController.text;
  CategoryModel? get selectedCategory => _selectedCategory;
  TownModel? get selectedDistrict => _selectedRegionalTownSubItem?.toTownModel;
  String get selectedCityId => _selectedRegionalCityModel.documentId;

  @override
  void initState() {
    super.initState();
    categoryModels = productState.categoryItems;
    regionalCityModels = productState.regionalCityItems;
    _regionalTownModels = productState.regionalTownItems;
    _selectedRegionalCityModel = productState.selectedCity;
    _syncTownsWithSelectedCity();
  }

  @override
  bool get isHasAnyData =>
      placeNameController.text.isNotEmpty ||
      placeDescriptionController.text.isNotEmpty ||
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

  void _changeCompanyMode({required bool isNew}) {
    if (_isNewCompanyMode == isNew) return;
    _isNewCompanyMode = isNew;
    if (isNew) {
      _clearCompanyAutofill();
      ref
          .read(merchantApplicationViewModelProvider.notifier)
          .clearSelectedCompany();
    }
    setState(() {});
  }

  void _clearCompanyAutofill() {
    placeNameController.clear();
    placeDescriptionController.clear();
    _selectedCompany = null;
    _selectedCategory = null;
    _selectedRegionalCityModel = productState.selectedCity;
    _syncTownsWithSelectedCity();
  }

  void _onCompanySelected(MerchantCompanyDropdownModel item) {
    _selectedCompany = item;
    _fillFromCompany(item.store);
    ref
        .read(merchantApplicationViewModelProvider.notifier)
        .selectCompany(item.store);
    setState(() {});
  }

  void _fillFromCompany(StoreModel store) {
    placeNameController.text = store.name;
    placeDescriptionController.text = store.description ?? '';
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
          _syncTownsWithSelectedCity();
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

  void _syncTownsWithSelectedCity() {
    _selectedRegionalTownModel = _regionalTownModels.firstWhere(
      (element) => element.cityId == _selectedRegionalCityModel.documentId,
      orElse: () => _regionalTownModels.first,
    );
    final towns = _selectedRegionalTownModel.towns;
    _selectedRegionalTownSubItem = towns.isEmpty ? null : towns.first;
  }

  void _onCityChanged(RegionalCityModel item) {
    _selectedRegionalCityModel = item;
    _syncTownsWithSelectedCity();
    setState(() {});
  }

  void _onTownChanged(RegionalTownSubItem item) {
    _selectedRegionalTownSubItem = item;
  }

  void _onCategorySelected(CategoryModel category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    placeNameController.dispose();
    placeDescriptionController.dispose();
  }
}
