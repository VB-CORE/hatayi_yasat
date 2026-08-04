import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/main/profile/view/edit/edit_profile_view_mixin.dart';
import 'package:lifeclient/features/main/profile/view/edit/widget/edit_profile_photo.dart';
import 'package:lifeclient/features/sub_feature/developers/view/widget/soft_arc_mosaic.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
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
      backgroundColor: context.appColors.white,
      appBar: PageAppBar(
        pageTitle: LocaleKeys.auth_editProfile_title,
        showDivider: false,
        backgroundColor: context.appColors.white.withAlpha(95),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: context.sized.dynamicHeight(.25),
              child: const RotatedBox(
                quarterTurns: 2,
                child: SoftArcMosaic(),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: .onDrag,
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: AppSpacing.sm,
                    children: [
                      const EmptyBox.largeHeight(),
                      EditProfilePhoto(
                        avatarType: avatarType,
                        onSelect: selectAvatarType,
                      ),
                      const EmptyBox.largeHeight(),
                      Padding(
                        padding: const PagePadding.horizontal16Symmetric(),
                        child: Column(
                          spacing: AppSpacing.sm,
                          children: [
                            LabeledProductTextField(
                              controller: displayNameController,
                              labelText: LocaleKeys.auth_editProfile_displayName
                                  .tr(),
                              hintText: LocaleKeys
                                  .auth_editProfile_displayNameHint
                                  .tr(),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: context.appColors.white,
        surfaceTintColor: context.appColors.white,
        child: GeneralButtonV2.async(
          action: updateProfile,
          label: LocaleKeys.button_save.tr(),
        ),
      ),
    );
  }
}
