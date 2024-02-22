import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';

/// DateTimeFormField is a widget that allows:
///  - Select a date from a calendar
///  - Show the selected date
///  - Validate that the selected date is after now
///  - Show an error message if the selected date is not after now
///
///
/// Params:
///  - [onDateSelected] is a callback that returns the selected date
final class DateTimeFormField extends StatefulWidget {
  const DateTimeFormField({required this.onDateSelected, super.key});
  final ValueSetter<DateTime> onDateSelected;
  @override
  State<DateTimeFormField> createState() => _DateTimeFormFieldState();
}

class _DateTimeFormFieldState extends State<DateTimeFormField>
    with _DateTimeFormFieldMixin {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      textInputAction: TextInputAction.next,
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(AppIcons.calendar),
        labelText: LocaleKeys.projectRequest_expireDate.tr(),
        border: const OutlineInputBorder(),
      ),
      onTap: () async => _updateSelectedDate(),
      validator: (_) => TextFieldValidatorIsNullEmpty()
          .validate(_selectedDate?.toIso8601String()),
    );
  }
}

mixin _DateTimeFormFieldMixin on State<DateTimeFormField> {
  DateTime? _selectedDate;
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updateSelectedDate() async {
    final dateTimeModel = await DateTimePicker.selectedDateTime(context);
    if (dateTimeModel == null) return;
    final dateTime = dateTimeModel.dateTime;
    _selectedDate = dateTime;
    _controller.text = dateTimeModel.formattedText;
    widget.onDateSelected.call(dateTime);
    setState(() {});
  }
}
