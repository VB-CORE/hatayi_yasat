import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

class ProductCheckbox extends FormField<bool> {
  ProductCheckbox({
    required Widget title,
    required FormFieldSetter<bool> super.onSaved,
    required FormFieldValidator<bool> super.validator,
    super.key,
    super.autovalidateMode,
    bool super.initialValue = false,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return ListTile(
              minLeadingWidth: 0,
              leading: Checkbox(
                activeColor: ColorsCustom.sambacus,
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
                      builder: (BuildContext context) => Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
}
