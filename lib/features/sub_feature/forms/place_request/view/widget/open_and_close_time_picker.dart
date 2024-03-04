import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/text_field/time_text_field.dart';

final class OpenAndCloseTimePicker extends StatefulWidget {
  const OpenAndCloseTimePicker({
    required this.openTimeController,
    required this.closeTimeController,
    super.key,
  });

  final TimePickerController openTimeController;
  final TimePickerController closeTimeController;

  @override
  State<OpenAndCloseTimePicker> createState() => _OpenAndCloseTimePickerState();
}

class _OpenAndCloseTimePickerState extends State<OpenAndCloseTimePicker> {
  OpenAndCloseTimeValidationModel model =
      const OpenAndCloseTimeValidationModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label(),
        _TextFields(
          closeTimeController: widget.closeTimeController,
          openTimeController: widget.openTimeController,
        ),
      ],
    );
  }
}

class _TextFields extends StatefulWidget {
  const _TextFields({
    required this.openTimeController,
    required this.closeTimeController,
  });

  final TimePickerController openTimeController;
  final TimePickerController closeTimeController;

  @override
  State<_TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<_TextFields> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.openTimeController,
      builder: (context, openTimeValue, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TimeFormField(
                controller: widget.openTimeController,
                hintText: LocaleKeys.requestCompany_start.tr(),
              ),
            ),
            const EmptyBox.largeWidth(),
            ValueListenableBuilder(
              valueListenable: widget.closeTimeController,
              builder: (context, closeTimeValue, _) {
                return Expanded(
                  child: TimeFormField(
                    useDefaultValidator: false,
                    controller: widget.closeTimeController,
                    hintText: LocaleKeys.requestCompany_end.tr(),
                    prefixIcon: AppIcons.timerOff,
                    validator: openTimeValue.text.ext.isNullOrEmpty
                        ? null
                        : (val) => ValidateCloseDate(
                              controller: widget.openTimeController,
                            ).validate(val),
                  ).ext.toDisabled(
                        disable: openTimeValue.text.ext.isNullOrEmpty,
                      ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.requestCompany_workingHours.tr(),
      style: context.general.textTheme.titleMedium,
    );
  }
}
