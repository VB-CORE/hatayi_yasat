import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lenghts.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';
import 'package:vbaseproject/product/widget/sheet/general_select_sheet.dart';
import 'package:vbaseproject/product/widget/text_field/widget/custom_text_field_decoration.dart';

final class CustomTextSelectionFormField extends StatelessWidget {
  const CustomTextSelectionFormField({
    required this.hint,
    required this.controller,
    required this.onSelected,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength = TextFieldMaxLengths.none,
    super.key,
  });
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextFieldMaxLengths maxLength;
  final ValueChanged<SelectSheetModel> onSelected;
  final ValidatorField validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength.value,
      readOnly: true,
      validator: validator.validate,
      inputFormatters: [FilteringTextInputFormatter.deny('')],
      keyboardType: textInputType,
      onTap: () async {
        final item = await GeneralSelectSheet.show(
          context,
          items: [
            const SelectSheetModel(title: 'a', id: '1'),
            const SelectSheetModel(title: 'b', id: '2'),
            const SelectSheetModel(title: 'c', id: '3'),
          ],
        );
        if (item == null) return;
        controller.text = item.title;
        onSelected.call(item);
      },
      decoration: CustomTextFieldDecoration(hint: hint, context: context),
    );
  }
}
