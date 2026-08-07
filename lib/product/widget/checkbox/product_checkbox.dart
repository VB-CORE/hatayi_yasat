import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
class ProductCheckbox extends FormField<bool> {
  ProductCheckbox({
    required Widget title,
    required FormFieldSetter<bool> super.onSaved,
    required FormFieldValidator<bool> super.validator,
    super.key,
    super.autovalidateMode,
    bool super.initialValue = false,
  }) : super(
          builder: (state) {
            return ListTile(
              minLeadingWidth: 0,
              leading: Checkbox(
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                  onSaved.call(value);
                },
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: AppConstants.kZero.toDouble(),
              title: title,
              subtitle: state.hasError
                  ? Builder(
                      builder: (context) => Text(
                        '**${state.errorText ?? ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
}
