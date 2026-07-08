import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

@immutable
final class CreateGroupSubmitButton extends StatefulWidget {
  const CreateGroupSubmitButton({
    required this.label,
    required this.icon,
    required this.isEnabled,
    required this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isEnabled;
  final AsyncCallback onPressed;

  @override
  State<CreateGroupSubmitButton> createState() =>
      _CreateGroupSubmitButtonState();
}

final class _CreateGroupSubmitButtonState
    extends State<CreateGroupSubmitButton> {
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
                  strokeWidth: 2,
                  color: contentColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, color: contentColor),
                  const SizedBox(width: AppIconSizes.small),
                  Text(
                    widget.label,
                    style: TextStyle(
                      inherit: false,
                      fontSize: WidgetSizes.spacingM,
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
