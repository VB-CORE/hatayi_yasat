import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_state.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_view.dart';
import 'package:vbaseproject/features/request/scholarship/viewmodel/request_scholarship_view_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/form_latest_data_dialog.dart';
import 'package:vbaseproject/product/widget/dialog/success_scholarship_posted_dialog.dart';

mixin RequestScholarshipMixin
    on
        AppProviderMixin<RequestScholarshipView>,
        ConsumerState<RequestScholarshipView> {
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController storyController;
  late final StateNotifierProvider<RequestScholarshipViewModel,
      RequestScholarshipState> requestProjectViewModel;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? pdfFile;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    storyController = TextEditingController();
    _initializeViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    storyController.dispose();
    formKey.currentState?.dispose();
  }

  RequestScholarshipModel get model => RequestScholarshipModel(
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        story: storyController.text,
        studentDocument: pdfFile ?? File(''),
      );

  bool get isLoading => ref.watch(requestProjectViewModel).isLoading;

  void _clear() {
    emailController.clear();
    phoneNumberController.clear();
    storyController.clear();
    pdfFile = null;
  }

  void _initializeViewModel() {
    requestProjectViewModel = StateNotifierProvider(
      (ref) => RequestScholarshipViewModel(),
    );
  }

  void updatePDFFile(File file) {
    pdfFile = file;
  }

  void changePolicyCheck(bool value) {
    ref.read(requestProjectViewModel.notifier).changePolicyCheck(value: value);
  }

  void changeLoading({required bool value}) {
    ref.read(requestProjectViewModel.notifier).changeLoading(value: value);
  }

  Future<void> uploadScholarshipStatus({required bool isSuccess}) async {
    if (!isSuccess) return;
    _clear();
    await SuccessScholarshipPostedDialog.show(context);
    if (!mounted) return;
    await context.route.pop();
  }

  Future<bool> onSavePressed() async {
    if (!formKey.currentState!.validate()) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_formRequired.tr());
      return false;
    }

    final isPolicyChecked = ref.read(requestProjectViewModel).isPolicyChecked;
    if (!isPolicyChecked) {
      appProvider.showSnackbarMessage(LocaleKeys.validation_kvkk.tr());
      return false;
    }

    ref.read(requestProjectViewModel.notifier).updateModel(model);

    final isSuccess =
        await ref.read(requestProjectViewModel.notifier).uploadScholarship();
    return isSuccess;
  }

  Future<void> uploadAndShowDialog() async {
    changeLoading(value: true);
    final isSuccess = await onSavePressed();
    changeLoading(value: false);
    await uploadScholarshipStatus(isSuccess: isSuccess);
  }

  bool get isAnyDataEntered =>
      emailController.text.isNotEmpty ||
      phoneNumberController.text.isNotEmpty ||
      storyController.text.isNotEmpty ||
      pdfFile != null;

  Future<bool> popScopeAction() async {
    if (isAnyDataEntered) {
      final response = await FormLatestDataDialog.show(context);
      return response;
    }
    return true;
  }
}
