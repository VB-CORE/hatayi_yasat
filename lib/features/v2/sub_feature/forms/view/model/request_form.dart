import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

abstract class RequestFormConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form == null) return false;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void onPop() {
    if (!validateAndSave()) return;
    context.route.pop();
  }

  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      canPop: false,
      onPopInvoked: (didPop) => didPop ? onPop() : null,
      child: onBuild(context),
    );
  }
}
