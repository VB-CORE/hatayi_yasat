import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/main/profile/view/profile_view.dart';
import 'package:lifeclient/features/sub_feature/web_view/app_about_web_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin ProfileViewMixin
    on ConsumerState<ProfileView>, AppProviderMixin<ProfileView> {
  Future<void> onAboutPressed() async {
    await showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => const AppAboutView(),
    );
  }

  Future<void> onSignOut() async {
    final confirmed = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.auth_signOut_title.tr(),
      LocaleKeys.auth_signOut_content.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_iAmSure,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      backgroundColor: AppColors.bg,
    );
    if (confirmed != true || !mounted) return;
    await ref.read(authViewModelProvider.notifier).signOut();
  }
}
