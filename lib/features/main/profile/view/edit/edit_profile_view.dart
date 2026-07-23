import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/main/profile/view/edit/edit_profile_view_mixin.dart';
import 'package:lifeclient/features/main/profile/view/edit/widget/edit_profile_photo.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/labeled_product_textfield.dart';

final class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

final class _EditProfileViewState extends ConsumerState<EditProfileView>
    with EditProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bg,
      appBar: PageAppBar(pageTitle: LocaleKeys.auth_editProfile_title),
      body: SingleChildScrollView(
        keyboardDismissBehavior: .onDrag,
        padding: const PagePadding.horizontal16Symmetric(),
        child: Form(
          key: formKey,
          child: Column(
            spacing: AppSpacing.sm,
            children: [
              ValueListenableBuilder<File?>(
                valueListenable: photoFileNotifier,
                builder: (context, photoFile, _) {
                  return EditProfilePhoto(
                    userName: displayNameController.text,
                    photoFile: photoFile,
                    photoUrl: currentPhotoUrl,
                    onTap: pickProfilePhoto,
                  );
                },
              ),
              LabeledProductTextField(
                controller: displayNameController,
                labelText: LocaleKeys.auth_editProfile_displayName.tr(),
                hintText: LocaleKeys.auth_editProfile_displayNameHint.tr(),
                validator: ValidatorNormalTextField().validate,
              ),
              LabeledProductTextField(
                controller: emailController,
                labelText: LocaleKeys.auth_editProfile_email.tr(),
                hintText: LocaleKeys.auth_editProfile_email.tr(),
                readOnly: true,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                validator: (_) => null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GeneralButtonV2.async(
          action: updateProfile,
          label: LocaleKeys.button_save.tr(),
        ),
      ),
    );
  }
}
