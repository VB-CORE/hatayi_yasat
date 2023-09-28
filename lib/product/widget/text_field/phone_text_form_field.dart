import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

import 'package:vbaseproject/product/model/constant/project_general_constant.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({required this.controller, super.key});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: ProjectGeneralConstant.phoneNumberHint,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      inputFormatters: [InputFormatter.instance.phoneFormatter],
      validator: (value) {
        return value.ext.phoneFormatValue.ext.isNotNullOrNoEmpty
            ? null
            : LocaleKeys.validation_phoneNumber.tr();
      },
    );
  }
}
