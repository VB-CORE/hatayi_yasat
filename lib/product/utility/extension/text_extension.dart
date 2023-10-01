import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text get withUnderline {
    return Text(
      data ?? 'as',
      style: style?.copyWith(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
