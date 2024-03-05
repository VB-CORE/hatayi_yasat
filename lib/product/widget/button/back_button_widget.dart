import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

/// A FloatingActionButton has a back button icon
///
/// Defaults:
/// - Width and height values are `WidgetSizes.spacingXxl9`
/// - Padding value is `PagePadding.allLow`
///
/// Params:
/// - `onPressed` is required VoidCallback for back button action
/// - `backgroundColor` is required Color for back button background color
@immutable
final class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    required this.onPressed,
    required this.backgroundColor,
    super.key,
  }) : _isTransparent = backgroundColor == Colors.transparent;

  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool _isTransparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.allLow(),
      width: WidgetSizes.spacingXxl9,
      height: WidgetSizes.spacingXxl9,
      child: FloatingActionButton(
        onPressed: onPressed,
        highlightElevation: _isTransparent ? kZero : null,
        elevation: _isTransparent ? kZero : null,
        backgroundColor: backgroundColor,
        child: Icon(
          AppIcons.leftSelect,
          size: WidgetSizes.spacingXxl5,
          color: context.general.colorScheme.secondary,
        ),
      ),
    );
  }
}
