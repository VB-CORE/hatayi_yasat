import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/company/modal/request_company_modal.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/firebase/town_model.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/success_data_posted_dialog.dart';

mixin RequestCompanyMixin
    on AppProviderMixin<RequestCompanyView>, ConsumerState<RequestCompanyView> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyDescriptionController =
      TextEditingController();
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? _imageFile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TownModel? _selectedTown;
  bool isFirstValidationCheck = false;

  RequestCompanyModel get model => RequestCompanyModel(
        companyName: companyNameController.text,
        companyDescription: companyDescriptionController.text,
        nameSurname: nameSurnameController.text,
        address: addressController.text,
        phone: phoneController.text,

        /// need to double check
        town: _selectedTown ?? TownModel(),
        imageFile: _imageFile ?? File(''),
      );

  Future<void> dataSendingComplete({required bool isOkay}) async {
    if (!isOkay) return;
    await SuccessDataPostedDialog.show(context);
    if (!mounted) return;
    await context.route.pop(true);
  }

  bool isCheckValidation() {
    if (_imageFile == null) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_photoRequired.tr());
      return false;
    }

    if (_selectedTown == null) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_formRequired.tr());
      return false;
    }

    final formCurrentState = formKey.currentState;
    if (formCurrentState == null || !formCurrentState.validate()) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_formRequired.tr());
      _isFormValidateCheck();
      return false;
    }
    return true;
  }

  void onTownSelected(TownModel value) {
    _selectedTown = value;
  }

  void onImageSelected(File value) {
    _imageFile = value;
  }

  void _isFormValidateCheck() {
    if (isFirstValidationCheck) return;
    setState(() {
      isFirstValidationCheck = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    companyDescriptionController.dispose();
    nameSurnameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    formKey.currentState?.dispose();
  }
}
