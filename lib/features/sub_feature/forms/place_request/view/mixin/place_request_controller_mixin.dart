import 'package:flutter/material.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/place_request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';

mixin PlaceRequestControllerMixin
    on RequestFormConsumerState<PlaceRequestForm> {
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

  void clearControllers() {
    placeNameController.clear();
    placeDescriptionController.clear();
    placeOwnerNameController.clear();
    placeAddressController.clear();
    placePhoneNumberController.clear();
    openTimeController.clear();
    closeTimeController.clear();
  }

  bool isControllerValid() {
    if (placeNameController.text.isNotEmpty) return true;
    if (placeDescriptionController.text.isNotEmpty) return true;
    if (placeOwnerNameController.text.isNotEmpty) return true;
    if (placeAddressController.text.isNotEmpty) return true;
    if (placePhoneNumberController.text.isNotEmpty) return true;
    if (placeCategoryController.text.isNotEmpty) return true;
    if (placeDistrictController.text.isNotEmpty) return true;
    return false;
  }
}
