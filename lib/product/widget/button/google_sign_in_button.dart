import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: double.infinity,
      height: 51,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.general.colorScheme.surface,
          foregroundColor: context.general.colorScheme.onSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: context.general.colorScheme.outlineVariant),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svg.svgGoogleIcon.svg(width: 20, height: 20),
            const EmptyBox.smallWidth(),
            Text(
              text,
              style: context.general.textTheme.titleMedium?.copyWith(
                color: context.general.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
