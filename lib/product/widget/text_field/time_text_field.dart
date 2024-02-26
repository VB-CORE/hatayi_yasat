import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';

final class TimeFormField extends StatefulWidget {
  const TimeFormField({
    required this.onTimeSelected,
    this.hintText,
    this.prefixIcon,
    super.key,
  });

  final ValueSetter<TimeOfDay> onTimeSelected;
  final String? hintText;
  final IconData? prefixIcon;

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
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon ?? AppIcons.timerOn),
      ),
      onTap: () async => _selectTime(),
      validator: (_) => TextFieldValidatorIsNullEmpty().validate(_time),
    );
  }

  String get _time {
    if (_selectedTime == null) return '';
    return _selectedTime.toString();
  }
}

mixin _TimeFormFieldMixin on State<TimeFormField> {
  TimeOfDay? _selectedTime;

  late final TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final selectedTime = await DateTimePicker.selectTime(context);
    if (selectedTime == null) return;

    _selectedTime = selectedTime;
    _timeController.text = '${selectedTime.hour}:${selectedTime.minute}';
    widget.onTimeSelected.call(selectedTime);
    setState(() {});
  }
}
