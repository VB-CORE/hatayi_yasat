import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/community/create_group/model/create_group_model.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_view_model.dart';
import 'package:lifeclient/features/community/create_group/view/create_group_view.dart';
import 'package:lifeclient/features/community/model/group_category_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/sheet/media_photo_sheet.dart';

mixin CreateGroupViewMixin
    on ConsumerState<CreateGroupView>, AppProviderMixin<CreateGroupView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? _coverImageFile;
  File? get coverImageFile => _coverImageFile;

  GroupCategoryModel? _selectedCategory;
  GroupCategoryModel? get selectedCategory => _selectedCategory;

  bool get isFormValid =>
      nameController.text.trim().length >= AppConstants.kThree &&
      _selectedCategory != null;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onFormFieldChanged);
    Future.microtask(() {
      ref.read(createGroupViewModelProvider.notifier).fetchCategories();
    });
  }

  @override
  void dispose() {
    nameController
      ..removeListener(_onFormFieldChanged)
      ..dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _onFormFieldChanged() => setState(() {});

  Future<void> pickCoverImage() async {
    final type = await MediaOrPhoto.openSheet(context);
    if (type == null) return;
    if (!mounted) return;
    final file = await PhotoPickerManager(context: context).pickPhoto(
      type: type,
    );
    if (file == null) return;
    setState(() => _coverImageFile = file);
  }

  void onCategorySelected(GroupCategoryModel category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? null : category;
    });
  }

  Future<void> submit() async {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final category = _selectedCategory;
    if (category == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.community_createGroup_categoryValidationError.tr(),
      );
      return;
    }

    final model = CreateGroupModel(
      name: nameController.text.trim(),
      category: category,
      description: descriptionController.text.trim(),
      coverImageFile: _coverImageFile,
    );

    final isCreated = await ref
        .read(createGroupViewModelProvider.notifier)
        .createGroup(model);
    if (!mounted) return;
    _handleSubmitResult(isCreated: isCreated);
  }

  void _handleSubmitResult({required bool isCreated}) {
    if (!isCreated) return;
    appProvider.showSnackbarMessage(
      LocaleKeys.community_createGroup_success.tr(),
    );
    context.pop();
  }
}
