import 'package:flutter/widgets.dart';

abstract interface class SubmitOnEnter {
  bool isSubmitKey(KeyEvent event);

  Widget wrap({required VoidCallback onSubmit, required Widget child});
}
