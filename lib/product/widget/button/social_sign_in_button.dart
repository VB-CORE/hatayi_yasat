import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

final class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    required this.text,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isLoading = false,
    this.elevation = 0,
    this.border,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final Widget icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;
  final double elevation;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: WidgetSizes.spacingXxl7,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
            side: border ?? BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: WidgetSizes.spacingL,
                height: WidgetSizes.spacingL,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const EmptyBox.smallWidth(),
                  Text(
                    text,
                    style: context.general.textTheme.bodyLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: .w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
