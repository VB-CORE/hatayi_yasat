import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

import '../size/widget_size.dart';

// TODO:(mehmetkaranlik) after implementation delete v2 from name

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
  const GeneralButtonV2._({
    required this.label,
    required this.action,
    required this.isAsync,
  });

  final String label;
  final FutureOr<void> Function() action;
  final bool isAsync;

  factory GeneralButtonV2.active({
    required VoidCallback action,
    required String label,
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: false,
    );
  }

  factory GeneralButtonV2.async({
    required AsyncCallback action,
    required String label,
  }) {
    return GeneralButtonV2._(
      label: label,
      action: action,
      isAsync: true,
    );
  }

  @override
  State<GeneralButtonV2> createState() => _GeneralButtonV2State();
}

class _GeneralButtonV2State extends State<GeneralButtonV2> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: ElevatedButton(
        style: _GeneralButtonStyle(context),
        onPressed: () async {
          if (!widget.isAsync) return widget.action();
          await _asyncAction();
        },
        child: ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (context, value, _) {
            if (!value) return _Child(label: widget.label);
            return const _LoadingWidget();
          },
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

// TODO: (mehmetkaranlik) move this style class to appropiate places
class _GeneralButtonStyle extends ButtonStyle {
  _GeneralButtonStyle(BuildContext context)
      : super(
          elevation: MaterialStatePropertyAll<double>(
            AppConstants.kTwo.toDouble(),
          ),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: context.border.lowBorderRadius,
              side: BorderSide(
                color:
                    ColorCommon(context).whiteAndBlackForTheme.withOpacity(0.5),
                width: AppConstants.kTwo.toDouble(),
              ),
            ),
          ),
        );
}
