import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/core/dependency/project_dependency_items.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/place_request_form.dart';
import 'package:vbaseproject/product/widget/sheet/general_select_sheet.dart';

mixin PlaceRequestFormMixin on RequestFormConsumerState<PlaceRequestForm> {
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

  SelectSheetModel? _selectedTownItem;
  SelectSheetModel? _selectedCategoryItem;

  @override
  bool get isHasAnyData {
    if (placeNameController.text.isNotEmpty) return true;
    if (placeDescriptionController.text.isNotEmpty) return true;
    if (placeOwnerNameController.text.isNotEmpty) return true;
    if (placeAddressController.text.isNotEmpty) return true;
    if (placePhoneNumberController.text.isNotEmpty) return true;
    if (placeCategoryController.text.isNotEmpty) return true;
    if (placeDistrictController.text.isNotEmpty) return true;
    return false;
  }

  void updateTownItem(SelectSheetModel item) => _selectedTownItem = item;
  void updateCategoryItem(SelectSheetModel item) =>
      _selectedCategoryItem = item;

  PlaceRequestModel? requestModel() {
    if (!validateAndSave()) return null;
    return PlaceRequestModel(
      placeName: placeNameController.text,
      placeDescription: placeDescriptionController.text,
      placeOwnerName: placeOwnerNameController.text,
      placeAddress: placeAddressController.text,
      placePhoneNumber: placePhoneNumberController.text,
      placeCategory: categoryModels.firstWhere(
        (element) => element.documentId == _selectedCategoryItem?.id,
      ),
      placeDistrict: townModels.firstWhere(
        (element) => element.documentId == _selectedTownItem?.id,
      ),
    );
  }

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
}
