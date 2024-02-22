import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

enum TextFieldFormatters {
  phone,
  none;

  const TextFieldFormatters();

  List<TextInputFormatter>? get value {
    switch (this) {
      case TextFieldFormatters.none:
        return null;
      case TextFieldFormatters.phone:
        return [
          InputFormatter.instance.phoneFormatter,
        ];
    }
  }
}
