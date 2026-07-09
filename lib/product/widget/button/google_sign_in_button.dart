import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/widget/button/social_sign_in_button.dart';

final class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SocialSignInButton(
      text: LocaleKeys.auth_signIn_continueWith.tr(
        namedArgs: {AuthProvider.argKey: AuthProvider.google.displayName},
      ),
      elevation: 1,
      onTap: onTap,
      isLoading: isLoading,
      backgroundColor: AppColors.white,
      foregroundColor: context.general.colorScheme.primary,
      border: BorderSide(color: context.general.colorScheme.outlineVariant),
      icon: Assets.svg.svgGoogleIcon.svg(
        width: WidgetSizes.spacingL,
        height: WidgetSizes.spacingL,
      ),
    );
  }
}
