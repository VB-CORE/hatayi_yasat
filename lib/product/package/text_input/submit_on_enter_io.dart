import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/package/text_input/submit_on_enter.dart';

final class PlatformSubmitOnEnter implements SubmitOnEnter {
  const PlatformSubmitOnEnter();

  @override
  bool isSubmitKey(KeyEvent event) => false;

  @override
  Widget wrap({required VoidCallback onSubmit, required Widget child}) => child;
}
