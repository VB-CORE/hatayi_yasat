import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/place_request_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/provider/place_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/mixin/place_request_controller_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/place_request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_form_success_dialog.dart';

mixin PlaceRequestFormMixin
    on
        AutomaticKeepAliveClientMixin<PlaceRequestForm>,
        AppProviderMixin<PlaceRequestForm>,
        RequestFormConsumerState<PlaceRequestForm>,
        PlaceRequestControllerMixin {
  late final List<CategoryModel> categoryModels;
  late final List<RegionalCityModel> regionalCityModels;
  late final List<RegionalTownModel> _regionalTownModels;

  CategoryModel? _selectedCategoryModel;
  LatLng? _selectedLocation;
  File? _imageFile;
  late RegionalCityModel _selectedRegionalCityModel;
  late RegionalTownModel _selectedRegionalTownModel;
  late RegionalTownSubItem? _selectedRegionalTownSubItem;

  RegionalCityModel get selectedRegionalCityModel => _selectedRegionalCityModel;
  RegionalTownModel get selectedRegionalTownModel => _selectedRegionalTownModel;
  RegionalTownSubItem? get selectedRegionalTownSubItem =>
      _selectedRegionalTownSubItem;
  CategoryModel? get selectedCategoryModel => _selectedCategoryModel;
  LatLng? get selectedLocation => _selectedLocation;

  final ValueNotifier<bool> isKVKKCheckedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    final productProviderState =
        ref.read(ProjectDependencyItems.productProviderState);
    categoryModels = productProviderState.categoryItems;
    regionalCityModels = productProviderState.regionalCityItems;
    _regionalTownModels = productProviderState.regionalTownItems;

    _selectedRegionalCityModel = productProviderState.selectedCity;
    _updateRegionalTown();
  }

  void _updateRegionalTown() {
    _selectedRegionalTownModel = _regionalTownModels.firstWhere(
      (element) => element.cityId == _selectedRegionalCityModel.documentId,
    );
    _selectedRegionalTownSubItem = _selectedRegionalTownModel.towns.first;
  }

  void clear() {
    clearControllers();
    _selectedCategoryModel = null;
    _imageFile = null;
  }

  @override
  bool get isHasAnyData {
    if (isControllerValid()) return true;

    if (openTimeController.isValid) return true;
    if (closeTimeController.isValid) return true;
    if (_imageFile != null) return true;
    return false;
  }

  void updateRegionalCityItem(RegionalCityModel item) {
    _selectedRegionalCityModel = item;
    _updateRegionalTown();
    setState(() {});
  }

  void updateRegionalTownItem(RegionalTownSubItem item) {
    _selectedRegionalTownSubItem = item;
  }

  void updateCategoryItem(CategoryModel item) {
    _selectedCategoryModel = item;
  }

  void updateKVKK({required bool value}) {
    isKVKKCheckedNotifier.value = value;
  }

  void onImageSelected(File value) {
    _imageFile = value;
  }

  void updateSelectedLocation(LatLng value) {
    _selectedLocation = value;
  }

  PlaceRequestModel? requestModel() {
    if (!validateAndSave()) return null;
    if (!_validateCategoryModel()) return null;
    if (!_validateTownModel()) return null;
    if (!_validateSelectedLocation()) return null;

    return PlaceRequestModel(
      selectedCityId: _selectedRegionalCityModel.documentId,
      placeName: placeNameController.text,
      placeDescription: placeDescriptionController.text,
      placeOwnerName: placeOwnerNameController.text,
      placeAddress: placeAddressController.text,
      placePhoneNumber: placePhoneNumberController.text,
      timeValidationModel: OpenAndCloseTimeValidationModel(
        closeTime: closeTimeController.time,
        openTime: openTimeController.time,
      ),
      placeCategory: _selectedCategoryModel!,
      placeDistrict: _selectedRegionalTownSubItem!.toTownModel,
      imageFile: _imageFile!,
      selectedLocation: _selectedLocation!,
    );
  }

  bool _validateCategoryModel() {
    final categoryModel = _selectedCategoryModel;
    if (categoryModel == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.validation_categoryEmpty.tr(),
      );
      return false;
    }
    return true;
  }

  bool _validateTownModel() {
    final townModel = _selectedRegionalTownSubItem;
    if (townModel == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.validation_districtEmpty.tr(),
      );
      return false;
    }
    return true;
  }

  bool _validateSelectedLocation() {
    final selectedLocation = _selectedLocation;
    if (selectedLocation == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.component_mapPicker_title.tr(),
      );
      return false;
    }

    return true;
  }

  @override
  bool validateAndSave() {
    final formResult = super.validateAndSave();
    if (!formResult) return false;
    if (!isKVKKCheckedNotifier.value) return false;
    if (_imageFile == null) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_photoRequired.tr());
      return false;
    }
    return true;
  }

  Future<void> dataSendingComplete({required bool isOkay}) async {
    if (!isOkay) return;
    clear();
    await GeneralFormSuccessDialog.show(
      context,
      LocaleKeys.dialog_completeRequest,
    );
    if (!mounted) return;
    context.pop();
  }

  Future<void> sendPlaceRequest() async {
    if (!validateAndSave()) return;
    final model = requestModel();
    if (model == null) return;
    final response = await ref
        .read(placeRequestProviderProvider.notifier)
        .addNewDataToService(model);
    await dataSendingComplete(isOkay: response);
  }
}
