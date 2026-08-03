import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_decoration.dart';

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
  const DateTimeFormField({
    required this.onDateSelected,
    this.labelText,
    this.hintText,
    this.initialDate,
    super.key,
  });

  final ValueSetter<DateTime> onDateSelected;
  final String? labelText;
  final String? hintText;
  final DateTime? initialDate;

  @override
  State<DateTimeFormField> createState() => _DateTimeFormFieldState();
}

class _DateTimeFormFieldState extends State<DateTimeFormField>
    with _DateTimeFormFieldMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DateFormFieldLabel(
          labelText:
              widget.labelText ?? LocaleKeys.projectRequest_dateInputTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        TextFormField(
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: _controller,
          decoration: CustomDateTimeFieldDecoration(
            context: context,
            suffixIcon: AppIcons.calendar,
            hint: widget.hintText ?? LocaleKeys.projectRequest_expireDate.tr(),
          ),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: context.general.colorScheme.onSecondaryFixed,
            fontWeight: FontWeight.w400,
          ),
          onTap: () async => _updateSelectedDate(),
          validator: (_) => TextFieldValidatorIsNullEmpty().validate(
            _selectedDate?.toIso8601String(),
          ),
        ),
      ],
    );
  }
}

final class _DateFormFieldLabel extends StatelessWidget {
  const _DateFormFieldLabel({required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return GeneralBodySmallTitle(
      labelText,
      fontWeight: FontWeight.w500,
      color: context.general.colorScheme.onPrimaryFixedVariant,
    );
  }
}

mixin _DateTimeFormFieldMixin on State<DateTimeFormField> {
  DateTime? _selectedDate;
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate;
    _selectedDate = initialDate;
    _controller = TextEditingController(
      text: initialDate == null
          ? ''
          : DateTimeFormatter.formatValueDetail(initialDate),
    );
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
