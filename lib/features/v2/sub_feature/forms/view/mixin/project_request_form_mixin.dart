import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/project_request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';

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

  DateTime? projectDate;
  File? projectImage;

  void updateProjectImage(File image) {
    projectImage = image;
  }

  void updateProjectDate(DateTime date) {
    projectDate = date;
  }

  RequestProjectModel? getRequestModel() {
    if (!validateAndSave()) return null;
    return RequestProjectModel(
      projectName: projectNameController.text,
      projectTopic: projectTopicController.text,
      projectDescription: projectDescriptionController.text,
      publisher: projectPublisherController.text,
      phone: projectPhoneController.text,
      expireDate: projectDate!,
      imageFile: projectImage!,
    );
  }

  @override
  bool get isHasAnyData {
    if (projectNameController.text.isNotEmpty) return true;
    if (projectTopicController.text.isNotEmpty) return true;
    if (projectDescriptionController.text.isNotEmpty) return true;
    if (projectPublisherController.text.isNotEmpty) return true;
    if (projectPhoneController.text.isNotEmpty) return true;
    if (projectDate != null) return true;
    if (projectImage != null) return true;
    return false;
  }

  @override
  bool validateAndSave() {
    final formResult = super.validateAndSave();
    if (!formResult) return false;
    if (projectImage == null) {
      appProvider
          .showSnackbarMessage(LocaleKeys.validation_pleaseAddImage.tr());
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    projectNameController.dispose();
    projectTopicController.dispose();
    projectDescriptionController.dispose();
    projectPublisherController.dispose();
    projectPhoneController.dispose();
    super.dispose();
  }
}
