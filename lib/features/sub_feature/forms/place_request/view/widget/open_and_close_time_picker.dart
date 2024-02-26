import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/widget/text_field/time_text_field.dart';

final class OpenAndCloseTimePicker extends StatefulWidget {
  const OpenAndCloseTimePicker({
    required this.onTimeSelected,
    super.key,
  });

  final void Function(OpenAndCloseTimeValidationModel model) onTimeSelected;

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
        Text(
          'İşletme çalışma saatleri',
          style: context.general.textTheme.titleMedium,
        ),
        Row(
          children: [
            Expanded(
              child: TimeFormField(
                hintText: 'Başlangıç',
                onTimeSelected: (openTime) {
                  model = model.copyWith(openTime: openTime);
                  widget.onTimeSelected(model);
                },
              ),
            ),
            const EmptyBox.largeWidth(),
            Expanded(
              child: TimeFormField(
                hintText: 'Bitiş',
                prefixIcon: AppIcons.timerOff,
                onTimeSelected: (closeTime) {
                  model = model.copyWith(closeTime: closeTime);
                  widget.onTimeSelected(model);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
