import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/main/profile/view/edit/edit_profile_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/widget/sheet/media_photo_sheet.dart';

mixin EditProfileViewMixin on ConsumerState<EditProfileView> {
  final formKey = GlobalKey<FormState>();
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final photoFileNotifier = ValueNotifier<File?>(null);

  String? currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authViewModelProvider).user;
    displayNameController.text = user?.displayName ?? '';
    emailController.text = user?.email ?? '';
    currentPhotoUrl = user?.photoUrl;
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    photoFileNotifier.dispose();
    super.dispose();
  }

  Future<void> pickProfilePhoto() async {
    final type = await MediaOrPhoto.openSheet(context);
    if (type == null || !mounted) return;

    final file = await PhotoPickerManager(context: context).pickPhoto(
      type: type,
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );
    if (file == null || !mounted) return;
    photoFileNotifier.value = file;
  }

  Future<void> saveProfile() async {
    if (formKey.currentState?.validate() != true) return;

    final userService = ProjectDependencyItems.userService;
    final photoFile = photoFileNotifier.value;

    String? photoUrl;

    if (photoFile != null) {
      photoUrl = await userService.uploadPhoto(photoFile);
      if (photoUrl == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.auth_editProfile_error.tr())),
        );
        return;
      }
    }

    final updated = await userService.update(
      displayName: displayNameController.text,
      photoUrl: photoUrl,
    );
    if (!mounted) return;

    if (!updated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.auth_editProfile_error.tr())),
      );
      return;
    }

    context.pop();
  }
}
