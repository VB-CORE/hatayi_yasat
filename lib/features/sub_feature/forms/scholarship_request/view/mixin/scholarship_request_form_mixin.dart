// ignore_for_file: use_setters_to_change_properties, avoid_positional_boolean_parameters

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/scholarship_request/provider/scholarship_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/scholarship_request/view/scholarship_request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/request_scholarship_model.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/index.dart';

mixin ScholarshipRequestFormMixin
    on
        AppProviderMixin<ScholarshipRequestForm>,
        RequestFormConsumerState<ScholarshipRequestForm> {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController bioController = TextEditingController();
  File? selectedPdfFile;

  /// TODO: This is a temporary solution. It should be removed after the KVKK checkbox is implemented.
  bool _isKvkkChecked = false;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(scholarshipRequestProviderProvider.notifier)
          .initializeForCanApply();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void _clear() {
    emailController.clear();
    phoneController.clear();
    bioController.clear();
    selectedPdfFile = null;
  }

  void updatePdfFile(File? file) {
    selectedPdfFile = file;
  }

  void updateKVKK(bool value) {
    _isKvkkChecked = value;
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

  Future<void> uploadAndShowDialog() async {
    final isSuccess = validateAndSave();
    await uploadScholarshipStatus(isSuccess: isSuccess);
  }

  Future<void> uploadScholarshipStatus({required bool isSuccess}) async {
    if (!isSuccess) return;

    _clear();
    await GeneralFormSuccessDialog.show(
      context,
      LocaleKeys.dialog_completeScholarshipRequest,
    );
    if (!mounted) return;
    context.pop();
  }

  Future<void> showErrorSnackbar({required String title}) async {
    appProvider.showSnackbarMessage(title);
  }
}
