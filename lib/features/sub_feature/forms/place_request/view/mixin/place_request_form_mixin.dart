// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';

import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/place_request_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/place_request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_form_success_dialog.dart';
import 'package:lifeclient/product/widget/sheet/general_select_sheet.dart';

mixin PlaceRequestFormMixin
    on
        AppProviderMixin<PlaceRequestForm>,
        RequestFormConsumerState<PlaceRequestForm> {
  late final List<TownModel> townModels;
  late final List<CategoryModel> categoryModels;
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeDescriptionController =
      TextEditingController();
  final TextEditingController placeOwnerNameController =
      TextEditingController();
  final TextEditingController placeAddressController = TextEditingController();
  final TextEditingController placePhoneNumberController =
      TextEditingController();
  final TextEditingController placeCategoryController = TextEditingController();
  final TextEditingController placeDistrictController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  OpenAndCloseTimeValidationModel get timeValidationModel {
    final openTimeHour = startTimeController.text.split(':').firstOrNull;
    final openTimeMinute = startTimeController.text.split(':').lastOrNull;

    final closeTimeHour = endTimeController.text.split(':').firstOrNull;
    final closeTimeMinute = endTimeController.text.split(':').lastOrNull;

    if (openTimeHour == null ||
        openTimeMinute == null ||
        closeTimeHour == null ||
        closeTimeMinute == null) {
      return const OpenAndCloseTimeValidationModel();
    } else {
      final openTime = TimeOfDay(
        hour: int.tryParse(openTimeHour)!,
        minute: int.tryParse(openTimeMinute)!,
      );

      final closeTime = TimeOfDay(
        hour: int.tryParse(closeTimeHour)!,
        minute: int.tryParse(closeTimeMinute)!,
      );

      return OpenAndCloseTimeValidationModel(
        openTime: openTime,
        closeTime: closeTime,
      );
    }
  }

  set timeValidationModel(OpenAndCloseTimeValidationModel model) {
    timeValidationModel = model;
  }

  SelectSheetModel? _selectedTownItem;
  SelectSheetModel? _selectedCategoryItem;
  File? _imageFile;
  bool _isKvkkChecked = false;

  @override
  void initState() {
    super.initState();
    final productProviderState =
        ref.read(ProjectDependencyItems.productProviderState);
    townModels = productProviderState.townItems;
    categoryModels = productProviderState.categoryItems;
  }

  @override
  void dispose() {
    super.dispose();
    placeNameController.dispose();
    placeDescriptionController.dispose();
    placeOwnerNameController.dispose();
    placeAddressController.dispose();
    placePhoneNumberController.dispose();
    placeCategoryController.dispose();
    placeDistrictController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
  }

  void clear() {
    placeNameController.clear();
    placeDescriptionController.clear();
    placeOwnerNameController.clear();
    placeAddressController.clear();
    placePhoneNumberController.clear();
    startTimeController.clear();
    endTimeController.clear();
    _selectedCategoryItem = null;
    _imageFile = null;
    _selectedTownItem = null;
    _isKvkkChecked = false;
  }

  @override
  bool get isHasAnyData {
    if (placeNameController.text.isNotEmpty) return true;
    if (placeDescriptionController.text.isNotEmpty) return true;
    if (placeOwnerNameController.text.isNotEmpty) return true;
    if (placeAddressController.text.isNotEmpty) return true;
    if (placePhoneNumberController.text.isNotEmpty) return true;
    if (placeCategoryController.text.isNotEmpty) return true;
    if (timeValidationModel.isValid) return true;
    if (_selectedTownItem != null) return true;
    if (_selectedCategoryItem != null) return true;
    if (_imageFile != null) return true;
    return false;
  }

  void updateTownItem(SelectSheetModel item) => _selectedTownItem = item;
  void updateCategoryItem(SelectSheetModel item) =>
      _selectedCategoryItem = item;

  /// TODO: This method should be updated with the new checkbox widget
  void updateKVKK(bool value) => _isKvkkChecked = value;

  void onImageSelected(File value) => _imageFile = value;

  PlaceRequestModel? requestModel() {
    if (!validateAndSave()) return null;
    return PlaceRequestModel(
      placeName: placeNameController.text,
      placeDescription: placeDescriptionController.text,
      placeOwnerName: placeOwnerNameController.text,
      placeAddress: placeAddressController.text,
      placePhoneNumber: placePhoneNumberController.text,
      timeValidationModel: timeValidationModel,
      placeCategory: categoryModels.firstWhere(
        (element) => element.documentId == _selectedCategoryItem?.id,
      ),
      placeDistrict: townModels.firstWhere(
        (element) => element.documentId == _selectedTownItem?.id,
      ),
      imageFile: _imageFile ?? File(''),
    );
  }

  @override
  bool validateAndSave() {
    final formResult = super.validateAndSave();
    if (!formResult) return false;
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
}
