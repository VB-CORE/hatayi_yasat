import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/product/widget/dialog/form_latest_data_dialog.dart';

abstract class RequestFormConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> with AutomaticKeepAliveClientMixin<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFirstValidateNotifier = ValueNotifier(false);

  bool get isHasAnyData;

  /// if user has any data and try to go back it will show dialog
  bool _isLatestDataCompleted = false;

  void _updateLatestDataComplete({required bool isCompleted}) {
    _isLatestDataCompleted = isCompleted;
  }

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

  /// when user make a mistake first time it is not show validation error
  /// then it will automatically show validation error
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
          canPop: false,
          autovalidateMode: isFirstValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          onPopInvoked: (didPop) async {
            /// manage to on pop logic
            if (_isLatestDataCompleted) return;
            if (!isHasAnyData) {
              _updateLatestDataComplete(isCompleted: true);
              context.pop();
              return;
            }
            final response = await FormLatestDataDialog.show(context);
            _updateLatestDataComplete(isCompleted: response);
            if (!context.mounted) return;
            if (response) context.pop();
          },
          child: child!,
        );
      },
      child: onBuild(context),
    );
  }
}
