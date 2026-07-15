import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Form step base without a pop guard: unlike [RequestFormConsumerState],
/// steps inside a multi-step flow must not register their own PopScope —
/// the orchestrator page owns the single exit dialog.
abstract class StepFormConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T>
    with AutomaticKeepAliveClientMixin<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFirstValidateNotifier = ValueNotifier(false);

  bool get isHasAnyData;

  @override
  bool get wantKeepAlive => true;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form == null) return false;
    final isValid = form.validate();
    if (isValid) form.save();
    _updateFirstValidate();
    return isValid;
  }

  void _updateFirstValidate() {
    if (_isFirstValidateNotifier.value) return;
    _isFirstValidateNotifier.value = true;
  }

  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<bool>(
      valueListenable: _isFirstValidateNotifier,
      builder: (context, isFirstValidate, child) {
        return Form(
          key: formKey,
          autovalidateMode: isFirstValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: child!,
        );
      },
      child: onBuild(context),
    );
  }
}
