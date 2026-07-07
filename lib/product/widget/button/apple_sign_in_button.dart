import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/button/social_sign_in_button.dart';

final class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({
    required this.text,
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SocialSignInButton(
      text: text,
      onTap: onTap,
      isLoading: isLoading,
      backgroundColor: AppColors.navy900,
      foregroundColor: context.general.colorScheme.onPrimary,

      icon: FaIcon(
        AppIcons.apple,
        color: context.general.colorScheme.onPrimary,
      ),
    );
  }
}
