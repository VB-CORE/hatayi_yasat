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
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_form_success_dialog.dart';
import 'package:lifeclient/product/widget/sheet/general_select_sheet.dart';

mixin PlaceRequestFormMixin
    on
        AppProviderMixin<PlaceRequestForm>,
        RequestFormConsumerState<PlaceRequestForm> {
  late final List<TownModel> townModels;
  late final List<CategoryModel> categoryModels;
  final TimePickerController openTimeController = TimePickerController();
  final TimePickerController closeTimeController = TimePickerController();
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
  final ValueNotifier<SelectSheetModel?> _selecteTownNotifier =
      ValueNotifier(null);

  final ValueNotifier<SelectSheetModel?> _selecteCategoryNotifier =
      ValueNotifier(null);

  final ValueNotifier<bool> isKVKKCheckedNotifier = ValueNotifier(false);

  File? _imageFile;

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
  }

  void clear() {
    placeNameController.clear();
    placeDescriptionController.clear();
    placeOwnerNameController.clear();
    placeAddressController.clear();
    placePhoneNumberController.clear();
    openTimeController.clear();
    closeTimeController.clear();
    _selecteCategoryNotifier.value = null;
    _imageFile = null;
    _selecteCategoryNotifier.value = null;
  }

  @override
  bool get isHasAnyData {
    if (placeNameController.text.isNotEmpty) return true;
    if (placeDescriptionController.text.isNotEmpty) return true;
    if (placeOwnerNameController.text.isNotEmpty) return true;
    if (placeAddressController.text.isNotEmpty) return true;
    if (placePhoneNumberController.text.isNotEmpty) return true;
    if (placeCategoryController.text.isNotEmpty) return true;
    if (_selecteTownNotifier.value != null) return true;
    if (_selecteCategoryNotifier.value != null) return true;
    if (openTimeController.isValid) return true;
    if (closeTimeController.isValid) return true;
    if (_imageFile != null) return true;
    return false;
  }

  void updateTownItem(SelectSheetModel item) {
    _selecteTownNotifier.value = item;
  }

  void updateCategoryItem(SelectSheetModel item) {
    _selecteCategoryNotifier.value = item;
  }

  void updateKVKK({required bool value}) {
    isKVKKCheckedNotifier.value = value;
  }

  void onImageSelected(File value) {
    _imageFile = value;
  }

  PlaceRequestModel? requestModel() {
    if (!validateAndSave()) return null;
    return PlaceRequestModel(
      placeName: placeNameController.text,
      placeDescription: placeDescriptionController.text,
      placeOwnerName: placeOwnerNameController.text,
      placeAddress: placeAddressController.text,
      placePhoneNumber: placePhoneNumberController.text,
      timeValidationModel: OpenAndCloseTimeValidationModel(
        closeTime: closeTimeController.time,
        openTime: openTimeController.time,
      ),
      placeCategory: categoryModels.firstWhere(
        (element) => element.documentId == _selecteCategoryNotifier.value?.id,
      ),
      placeDistrict: townModels.firstWhere(
        (element) => element.documentId == _selecteTownNotifier.value?.id,
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
