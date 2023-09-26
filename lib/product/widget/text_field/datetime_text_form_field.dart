import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/formatter/date_time_formatter.dart';
import 'package:vbaseproject/product/utility/constants/date_time_constant.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';

class DateTimeTextFormField extends StatelessWidget {
  const DateTimeTextFormField({
    required this.labelText,
    required this.controller,
    required this.validator,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final ValidatorField validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: TextFormField(
        controller: controller,
        validator: validator.validate,
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          labelText: labelText.tr(),
          border: const OutlineInputBorder(),
        ),
        onTap: () async => _selectDate(context, controller),
      ),
    );
  }
}

Future<void> _selectDate(
  BuildContext context,
  TextEditingController controller,
) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTimeConstants.dateTimeTomorrow,
    firstDate: DateTimeConstants.dateTimeTomorrow,
    lastDate: DateTimeConstants.selectableLastYear,
  );

  if (pickedDate == null) return;
  controller.text = DateTimeFormatter.formatValue(pickedDate);
}
