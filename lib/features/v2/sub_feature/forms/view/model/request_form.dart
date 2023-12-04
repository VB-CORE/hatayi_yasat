import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

abstract class RequestFormConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFirstValidateNotifier = ValueNotifier(false);

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form == null) return false;
    final isValid = form.validate();
    if (isValid) form.save();

    _updateFirstValidate();
    return isValid;
  }

  /// when user make a mistake first time it is not show validation error
  /// then it will automatically show validation error
  void _updateFirstValidate() {
    if (_isFirstValidateNotifier.value) return;
    _isFirstValidateNotifier.value = true;
  }

  void onPop() {
    if (!validateAndSave()) return;
    context.route.pop();
  }

  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFirstValidateNotifier,
      builder: (context, isFirstValidate, child) {
        return Form(
          key: formKey,
          canPop: false,
          autovalidateMode: isFirstValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          onPopInvoked: (didPop) => didPop ? onPop() : null,
          child: child!,
        );
      },
      child: onBuild(context),
    );
  }
}
