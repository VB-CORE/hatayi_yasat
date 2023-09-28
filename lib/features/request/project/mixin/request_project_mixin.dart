import 'dart:ffi';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';
import 'package:vbaseproject/features/request/project/request_project_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/form_latest_data_dialog.dart';
import 'package:vbaseproject/product/widget/dialog/success_data_posted_dialog.dart';

mixin RequestProjectMixin
    on AppProviderMixin<RequestProjectView>, ConsumerState<RequestProjectView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  ValueNotifier<DateTime?> startDateNotifier = ValueNotifier(null);

  DateTime? endDate;
  File? _imageFile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isFirstValidationCheck = false;
  bool _isEndDateLessThanStartDate = false;

  bool get isAnyDataEntered =>
      nameController.text.isNotEmpty ||
      topicController.text.isNotEmpty ||
      descriptionController.text.isNotEmpty ||
      publisherController.text.isNotEmpty ||
      startDateController.text.isNotEmpty ||
      endDateController.text.isNotEmpty ||
      _imageFile != null;

  Future<bool> checkBackButton() async {
    if (isAnyDataEntered) {
      final response = await FormLatestDataDialog.show(context);
      return response;
    }
    return true;
  }

  AutovalidateMode autoValidate() {
    return _isFirstValidationCheck
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;
  }

  late RequestProjectModel model;

  Future<void> dataSendingComplete({required bool isOkay}) async {
    if (!isOkay) return;
    clear();
    await SuccessDataPostedDialog.show(context);
    if (!mounted) return;
    await context.route.pop(true);
  }

  void updateSelectedDate({required bool isStart, required DateTime value}) {
    if (isStart) {
      startDateNotifier.value = value;
      return;
    }
    endDate = value;
  }

  bool isCheckValidation() {
    _isFormValidateCheck();

    if (_imageFile == null) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_photoRequired.tr());
      return false;
    }

    final formCurrentState = formKey.currentState;
    if (formCurrentState == null || !formCurrentState.validate()) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_formRequired.tr());
      return false;
    }

    _isEndDateLessThanStartDateCheck();
    if (!_isEndDateLessThanStartDate) {
      appProvider.showSnackbarMessage(
        LocaleKeys.validation_endDateNotLessThanStartDate.tr(),
      );
      return false;
    }

    model = RequestProjectModel(
      projectName: nameController.text,
      projectTopic: topicController.text,
      projectDescription: descriptionController.text,
      publisher: publisherController.text,
      startDate: startDateNotifier.value!,
      endDate: endDate!,
      imageFile: _imageFile!,
    );

    return true;
  }

  void clear() {
    nameController.clear();
    descriptionController.clear();
    publisherController.clear();
    topicController.clear();
    startDateController.clear();
    endDateController.clear();
    _imageFile = null;
    _isFirstValidationCheck = false;
    _isEndDateLessThanStartDate = false;
  }

  void onImageSelected(File value) {
    _imageFile = value;
  }

  void _isFormValidateCheck() {
    if (_isFirstValidationCheck) return;
    setState(() {
      _isFirstValidationCheck = true;
    });
  }

  void _isEndDateLessThanStartDateCheck() {
    if (_isEndDateLessThanStartDate) return;

    final startDateConvert = startDateNotifier.value;
    final endDateConvert = endDate;
    if (startDateConvert == null || endDateConvert == null) return;

    if (!_isEndDateLessThanStartDateFunc(startDateConvert, endDateConvert)) {
      setState(() {
        _isEndDateLessThanStartDate = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    topicController.dispose();
    descriptionController.dispose();
    publisherController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    formKey.currentState?.dispose();
  }
}

bool _isEndDateLessThanStartDateFunc(DateTime startDate, DateTime endDate) {
  final compareResult = startDate.compareTo(endDate);
  if (compareResult < 0) {
    return false;
  }
  return true;
}
