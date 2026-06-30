import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: .infinity,
      height: 51,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.general.colorScheme.onSurface,
          foregroundColor: context.general.colorScheme.surface,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            FaIcon(
              AppIcons.apple,
              color: context.general.colorScheme.surface,
            ),
            const EmptyBox.smallWidth(),
            Text(
              text,
              style: context.general.textTheme.titleMedium?.copyWith(
                color: context.general.colorScheme.surface,
                fontWeight: .w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
