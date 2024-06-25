import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';
import 'package:lifeclient/product/utility/extension/time_of_day_extension.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_decoration.dart';

final class TimeFormField extends StatefulWidget {
  const TimeFormField({
    this.onTimeSelected,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.useDefaultValidator = true,
    super.key,
  });

  final ValueSetter<TimeOfDay>? onTimeSelected;
  final String? hintText;
  final IconData? prefixIcon;
  final TimePickerController? controller;
  final String? Function(String?)? validator;
  final bool useDefaultValidator;
  @override
  State<TimeFormField> createState() => _TimeFormFieldState();
}

class _TimeFormFieldState extends State<TimeFormField>
    with _TimeFormFieldMixin {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _timeController,
      decoration: NewCustomTimeFieldDecoration(
        context: context,
        hint: widget.hintText,
        prefixIcon: widget.prefixIcon,
      ),
      style: context.general.textTheme.titleMedium?.copyWith(
        color: context.general.colorScheme.onSecondaryFixed,
        fontWeight: FontWeight.w400,
      ),
      onTap: () async => _selectTime(),
      validator: widget.validator ??
          (widget.useDefaultValidator
              ? (text) => TextFieldValidatorIsNullEmpty().validate(text)
              : null),
    );
  }
}

mixin _TimeFormFieldMixin on State<TimeFormField> {
  late final TimePickerController _timeController;

  @override
  void initState() {
    super.initState();
    _timeController = widget.controller ?? TimePickerController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _timeController.dispose();
    }
    super.dispose();
  }

  Future<void> _selectTime() async {
    final selectedTime = await DateTimePicker.selectTime(context);
    if (selectedTime == null) return;
    _timeController.text = selectedTime.stringValue;
    widget.onTimeSelected?.call(selectedTime);
  }
}
