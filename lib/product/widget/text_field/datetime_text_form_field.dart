import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/formatter/date_time_formatter.dart';
import 'package:vbaseproject/product/utility/constants/date_time_constant.dart';
import 'package:vbaseproject/product/utility/constants/time_of_day_constant.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';

final class DateTimeTextFormField extends StatelessWidget {
  const DateTimeTextFormField({
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.onDateSelected,
    required this.startDate,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final ValidatorField validator;
  final DateTime? startDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: TextFormField(
        controller: controller,
        validator: validator.validate,
        readOnly: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          labelText: labelText.tr(),
          border: const OutlineInputBorder(),
        ),
        onTap: () async => _selectedDateTime(context, controller),
      ),
    );
  }

  Future<void> _selectedDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final selectDate = await _selectDate(context);
    if (!context.mounted) return;
    final selectTime = await _selectTime(context);

    final selectedDateAndTime = DateTime(
      selectDate.year,
      selectDate.month,
      selectDate.day,
      selectTime.hour,
      selectTime.minute,
    );

    controller.text = DateTimeFormatter.formatValueDetail(selectedDateAndTime);
    onDateSelected.call(selectedDateAndTime);
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTimeConstants.dateTimeTomorrow,
      firstDate: DateTimeConstants.dateTimeTomorrow,
      lastDate: DateTimeConstants.selectableLastYear,
    );
    if (pickedDate == null) return DateTimeConstants.dateTimeTomorrow;
    return pickedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    var initialTimeOfDay = TimeOfDayConstants.timeOfDayNow;
    if (startDate != null) {
      initialTimeOfDay = TimeOfDay.fromDateTime(startDate!);
    }
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTimeOfDay,
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );
    if (pickedTime == null) return TimeOfDayConstants.timeOfDayNow;
    return pickedTime;
  }
}
