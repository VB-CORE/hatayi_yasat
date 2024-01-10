// ignore_for_file: use_setters_to_change_properties, avoid_positional_boolean_parameters

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/scholarship_request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/request_scholarship_model.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';

mixin ScholarshipRequestFormMixin
    on
        AppProviderMixin<ScholarshipRequestForm>,
        RequestFormConsumerState<ScholarshipRequestForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File? selectedPdfFile;
  bool isKvkkChecked = false;

  @override
  bool get isHasAnyData {
    if (emailController.text.isNotEmpty) return true;
    if (phoneController.text.isNotEmpty) return true;
    if (bioController.text.isNotEmpty) return true;
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void updatePdfFile(File? file) {
    selectedPdfFile = file;
  }

  void updateKVKK(bool value) {
    isKvkkChecked = value;
  }

  @override
  bool validateAndSave() {
    final formResult = super.validateAndSave();
    if (!formResult) return false;
    if (selectedPdfFile == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.requestScholarship_error_noFileError.tr(),
      );
      return false;
    }
    return true;
  }

  RequestScholarshipModel? getRequestModel() {
    if (!validateAndSave()) return null;
    return RequestScholarshipModel(
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      story: bioController.text.trim(),
      studentDocument: selectedPdfFile,
    );
  }
}
