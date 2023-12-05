import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class CustomTextFieldDecoration extends InputDecoration {
  CustomTextFieldDecoration({
    required String hint,
    required BuildContext context,
  }) : super(
          labelText: hint,
          focusColor: context.general.colorScheme.onError,
          focusedBorder: const UnderlineInputBorder(),
          hintStyle: context.general.textTheme.titleMedium,
          border: const UnderlineInputBorder(),
          contentPadding: EdgeInsets.zero,
        );
}
