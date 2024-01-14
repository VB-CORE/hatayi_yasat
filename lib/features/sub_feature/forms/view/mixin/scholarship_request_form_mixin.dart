// ignore_for_file: use_setters_to_change_properties, avoid_positional_boolean_parameters

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/scholarship_request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/request_scholarship_model.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/success_scholarship_posted_dialog.dart';

mixin ScholarshipRequestFormMixin
    on
        AppProviderMixin<ScholarshipRequestForm>,
        RequestFormConsumerState<ScholarshipRequestForm> {
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bioController;
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
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    bioController = TextEditingController();
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

  void _clear() {
    emailController.clear();
    phoneController.clear();
    bioController.clear();
    selectedPdfFile = null;
  }

  Future<void> uploadAndShowDialog() async {
    final isSuccess = validateAndSave();
    await uploadScholarshipStatus(isSuccess: isSuccess);
  }

  Future<void> uploadScholarshipStatus({required bool isSuccess}) async {
    if (!isSuccess) return;

    _clear();
    await SuccessScholarshipPostedDialog.show(context);
    if (!mounted) return;
    context.pop();
  }
}
