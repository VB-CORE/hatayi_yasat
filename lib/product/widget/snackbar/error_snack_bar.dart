import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({required String message, super.key})
      : super(
          content: Text(message),
        );
}
