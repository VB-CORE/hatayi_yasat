import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// General button for all project
/// For async action use async constructor
/// For sync action use active constructor
///
/// Example:
/// ```dart
/// GeneralButtonV2.active(
///  action: () => print('action'),
///  label: 'label',
///  ),
///
/// GeneralButtonV2.async(
/// action: () async => print('action'),
/// label: 'label',
/// ),
/// ```
@immutable
final class GeneralButtonV2 extends StatefulWidget {
  factory GeneralButtonV2.active({
    required VoidCallback action,
    required String label,
    bool isEnabled = true,
    bool isBorderless = false,
    IconData? icon,
    IconAlignment? iconAlignment,
    Color? backgroundColor,
    EdgeInsets buttonPadding = const PagePadding.vertical12Symmetric(),
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: false,
      isEnabled: isEnabled,
      buttonPadding: buttonPadding,
      isBorderless: isBorderless,
      icon: icon,
      iconAlignment: iconAlignment,
      backgroundColor: backgroundColor,
    );
  }

  factory GeneralButtonV2.async({
    required AsyncCallback action,
    required String label,
    bool isEnabled = true,
    bool isBorderless = false,
    IconData? icon,
    IconAlignment? iconAlignment,
    Color? backgroundColor,
    EdgeInsets buttonPadding = const PagePadding.vertical12Symmetric(),
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: true,
      isEnabled: isEnabled,
      buttonPadding: buttonPadding,
      isBorderless: isBorderless,
      icon: icon,
      iconAlignment: iconAlignment,
      backgroundColor: backgroundColor,
    );
  }
  const GeneralButtonV2._({
    required this.label,
    required this.action,
    required this.isAsync,
    this.isEnabled = true,
    this.isBorderless = false,
    this.icon,
    this.iconAlignment,
    this.backgroundColor,
    this.buttonPadding = const PagePadding.vertical12Symmetric(),
  });

  final String label;
  final FutureOr<void> Function() action;
  final bool isAsync;
  final bool isEnabled;
  final bool isBorderless;
  final IconData? icon;
  final IconAlignment? iconAlignment;
  final Color? backgroundColor;
  final EdgeInsets buttonPadding;
  @override
  State<GeneralButtonV2> createState() => _GeneralButtonV2State();
}

final class _GeneralButtonV2State extends State<GeneralButtonV2> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: DurationConstant.durationLow,
      opacity: widget.isEnabled ? 1 : 0.3,
      child: ElevatedButton(
        style: widget.isBorderless
            ? _BorderlessGeneralButtonStyle(widget.backgroundColor)
            : _GeneralButtonStyle(widget.backgroundColor),
        onPressed: !widget.isEnabled
            ? null
            : () async {
                if (!widget.isAsync) return widget.action();
                await _asyncAction();
              },
        child: Padding(
          padding: widget.buttonPadding,
          child: ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (context, value, _) {
              if (!value) {
                return _Child(
                  label: widget.label,
                  icon: widget.icon,
                  iconAlignment: widget.iconAlignment,
                );
              }
              return const _LoadingWidget();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _asyncAction() async {
    if (_isLoading.value) return;
    _changeLoading();
    await widget.action();
    _changeLoading();
  }

  void _changeLoading() {
    _isLoading.value = !_isLoading.value;
  }
}

class _Child extends StatelessWidget {
  const _Child({
    required this.label,
    this.icon,
    this.iconAlignment,
  });

  final String label;
  final IconData? icon;
  final IconAlignment? iconAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          _buildRow(context, canFlex: constraints.hasBoundedWidth),
    );
  }

  Widget _buildRow(BuildContext context, {required bool canFlex}) {
    final contentColor = context.general.colorScheme.surface;

    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: contentColor,
        fontWeight: FontWeight.w900,
      ),
    );
    final labelWidget = canFlex ? Flexible(child: text) : text;
    final mainAxisSize = canFlex ? MainAxisSize.max : MainAxisSize.min;

    if (icon == null) {
      return Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [labelWidget],
      );
    }
    final iconWidget = Icon(icon, color: contentColor);
    final alignment = iconAlignment ?? IconAlignment.start;
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: MainAxisAlignment.center,
      children: switch (alignment) {
        IconAlignment.start => [
          iconWidget,
          const EmptyBox.smallWidth(),
          labelWidget,
        ],
        IconAlignment.end => [
          labelWidget,
          const EmptyBox.smallWidth(),
          iconWidget,
        ],
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: WidgetSizes.spacingXl,
        width: WidgetSizes.spacingXl,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

final class _BorderlessGeneralButtonStyle extends ButtonStyle {
  _BorderlessGeneralButtonStyle(Color? backgroundColor)
    : super(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor ?? AppColors.coral,
        ),
        shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
      );
}

final class _GeneralButtonStyle extends ButtonStyle {
  _GeneralButtonStyle(Color? backgroundColor)
    : super(
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor ?? AppColors.coral,
        ),
        shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
            side: BorderSide(
              color: backgroundColor ?? AppColors.coral,
              width: AppConstants.kTwo.toDouble(),
            ),
          ),
        ),
      );
}
