import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

@immutable
final class CommunitySubmitButton extends StatefulWidget {
  const CommunitySubmitButton({
    required this.label,
    required this.isEnabled,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final IconData? icon;
  final bool isEnabled;
  final AsyncCallback onPressed;

  @override
  State<CommunitySubmitButton> createState() => _CommunitySubmitButtonState();
}

final class _CommunitySubmitButtonState extends State<CommunitySubmitButton> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await widget.onPressed();
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final contentColor = widget.isEnabled ? AppColors.white : AppColors.ink400;
    final themeLabelStyle = context.general.textTheme.titleMedium;
    return SizedBox(
      width: double.infinity,
      height: WidgetSizes.spacingXxl7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          disabledBackgroundColor: AppColors.ink100,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.ink400,
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        onPressed: widget.isEnabled ? _handleTap : null,
        child: _isLoading
            ? SizedBox(
                width: WidgetSizes.spacingL,
                height: WidgetSizes.spacingL,
                child: CircularProgressIndicator(
                  strokeWidth: WidgetSizes.spacingXSS,
                  color: contentColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: contentColor),
                    const EmptyBox.smallWidth(),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      inherit: false,
                      fontSize: themeLabelStyle?.fontSize,
                      fontWeight: FontWeight.w800,
                      color: contentColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
