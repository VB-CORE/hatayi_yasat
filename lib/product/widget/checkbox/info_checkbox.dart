import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/checkbox/product_checkbox.dart';

class InfoCheckBox extends StatelessWidget {
  const InfoCheckBox(this.autovalidateMode, {super.key});
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ProductCheckbox(
      autovalidateMode: autovalidateMode,
      title: const Text('LocaleKeys.confirmationText.tr()'),
      onSaved: (value) {},
      validator: (value) {
        return value != null && value == true
            ? null
            : 'LocaleKeys.validation_confirmationText.tr()';
      },
    );
  }
}
