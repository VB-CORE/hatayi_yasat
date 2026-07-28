import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/main/profile/view/edit/edit_profile_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type.dart';

mixin EditProfileViewMixin on ConsumerState<EditProfileView> {
  final formKey = GlobalKey<FormState>();
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();

  AvatarType avatarType = AvatarType.a1;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authViewModelProvider).user;
    displayNameController.text = user?.displayName ?? '';
    emailController.text = user?.email ?? '';
    avatarType = user?.avatarType ?? AvatarType.a1;
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void selectAvatarType(AvatarType type) {
    setState(() => avatarType = type);
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() != true) return;

    final isUpdated = await ProjectDependencyItems.userService.update(
      displayName: displayNameController.text,
      avatarType: avatarType,
    );

    if (!isUpdated) return _showError();

    if (!mounted) return;
    context.pop();
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocaleKeys.auth_editProfile_error.tr())),
    );
  }
}
