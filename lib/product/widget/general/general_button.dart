import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/duration_constant.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

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
    EdgeInsets buttonPadding = const PagePadding.vertical12Symmetric(),
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: false,
      isEnabled: isEnabled,
      buttonPadding: buttonPadding,
    );
  }

  factory GeneralButtonV2.async({
    required AsyncCallback action,
    required String label,
    bool isEnabled = true,
    EdgeInsets buttonPadding = const PagePadding.vertical12Symmetric(),
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: true,
      isEnabled: isEnabled,
      buttonPadding: buttonPadding,
    );
  }
  const GeneralButtonV2._({
    required this.label,
    required this.action,
    required this.isAsync,
    this.isEnabled = true,
    this.buttonPadding = const PagePadding.vertical12Symmetric(),
  });

  final String label;
  final FutureOr<void> Function() action;
  final bool isAsync;
  final bool isEnabled;
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
        style: _GeneralButtonStyle(context),
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
              if (!value) return _Child(label: widget.label);
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
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: context.general.textTheme.titleMedium?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
          fontWeight: FontWeight.w900,
        ),
      ),
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

final class _GeneralButtonStyle extends ButtonStyle {
  _GeneralButtonStyle(BuildContext context)
      : super(
          backgroundColor: MaterialStateProperty.all<Color>(
            context.general.colorScheme.secondary,
          ),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: CustomRadius.medium,
              side: BorderSide(
                color: context.general.colorScheme.primary,
                width: AppConstants.kTwo.toDouble(),
              ),
            ),
          ),
        );
}

final class _GeneralButtonEmptyStyle extends ButtonStyle {
  _GeneralButtonEmptyStyle(BuildContext context)
      : super(
          backgroundColor: MaterialStateProperty.all<Color>(
            context.general.colorScheme.secondary,
          ),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: CustomRadius.medium,
              side: BorderSide(
                color: context.general.colorScheme.primary.withOpacity(0.3),
                width: AppConstants.kTwo.toDouble(),
              ),
            ),
          ),
        );
}
