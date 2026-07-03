import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/widget/button/social_sign_in_button.dart';

final class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
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
      elevation: 1,
      onTap: onTap,
      isLoading: isLoading,
      backgroundColor: context.general.colorScheme.surface,
      foregroundColor: context.general.colorScheme.primary,
      border: BorderSide(color: context.general.colorScheme.outlineVariant),
      icon: Assets.svg.svgGoogleIcon.svg(width: 20, height: 20),
    );
  }
}
