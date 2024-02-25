// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/sub_feature/forms/project_request/view/project_request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/request_project_model.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/general_form_success_dialog.dart';

mixin ProjectRequestFormMixin
    on
        AppProviderMixin<ProjectRequestForm>,
        RequestFormConsumerState<ProjectRequestForm> {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectTopicController = TextEditingController();
  final TextEditingController projectDescriptionController =
      TextEditingController();
  final TextEditingController projectPublisherController =
      TextEditingController();
  final TextEditingController projectPhoneController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();
  DateTime? expireDate;
  File? _imageFile;
  bool _isKvkkChecked = false;

  RequestProjectModel? getRequestModel() {
    if (!validateAndSave()) return null;
    return RequestProjectModel(
      projectName: projectNameController.text,
      projectTopic: projectTopicController.text,
      projectDescription: projectDescriptionController.text,
      publisher: projectPublisherController.text,
      phone: projectPhoneController.text,
      expireDate: expireDate!,
      imageFile: _imageFile!,
    );
  }

  @override
  bool get isHasAnyData {
    if (projectNameController.text.isNotEmpty) return true;
    if (projectTopicController.text.isNotEmpty) return true;
    if (projectDescriptionController.text.isNotEmpty) return true;
    if (projectPublisherController.text.isNotEmpty) return true;
    if (projectPhoneController.text.isNotEmpty) return true;
    if (expireDateController.text.isNotEmpty) return true;
    if (_imageFile != null) return true;
    return false;
  }

  @override
  bool validateAndSave() {
    final formResult = super.validateAndSave();
    if (!formResult) return false;
    if (_imageFile == null) {
      appProvider
          .showSnackbarMessage(LocaleKeys.validation_pleaseAddImage.tr());
      return false;
    }
    return true;
  }

  void onImageSelected(File value) {
    _imageFile = value;
  }

  void updateSelectedDateTime({required DateTime value}) {
    expireDate = value;
  }

  /// TODO: This method should be updated with the new checkbox widget
  void updateKVKK(bool value) => _isKvkkChecked = value;

  void clear() {
    projectNameController.clear();
    projectDescriptionController.clear();
    projectPublisherController.clear();
    projectTopicController.clear();
    expireDateController.clear();
    projectPhoneController.clear();
    _imageFile = null;
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

  @override
  void dispose() {
    projectNameController.dispose();
    projectTopicController.dispose();
    projectDescriptionController.dispose();
    projectPublisherController.dispose();
    projectPhoneController.dispose();
    expireDateController.dispose();
    super.dispose();
  }
}
