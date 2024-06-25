import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/dropdown/widget/custom_dropdown_decoration.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

/// A custom dropdown form field widget that allows selection from a list of items
/// of type [T], where [T] extends [BaseDropDownModel].
///
/// - [items] is a list of items to display in the dropdown.
/// - [onSelected] is a callback function to handle the selected item.
/// - [hint] is a placeholder text displayed when no item is selected.

final class CustomDropdownFormField<T extends BaseDropDownModel>
    extends StatefulWidget {
  const CustomDropdownFormField({
    required this.items,
    required this.onSelected,
    required this.hint,
    super.key,
  });

  final List<T> items;
  final ValueChanged<T> onSelected;
  final String hint;

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDistrictSelectionFormFieldState<T>();
}

final class _CustomDistrictSelectionFormFieldState<T extends BaseDropDownModel>
    extends State<CustomDropdownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(widget.hint),
      validator: DropdownModelValidate().validateDropDownField,
      decoration: CustomDropdownDecoration(context: context),
      dropdownColor: context.general.colorScheme.onPrimaryFixed,
      elevation: 0,
      items: widget.items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: GeneralBodySmallTitle(
                e.displayName,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
          .toList(),
      onChanged: (val) {
        if (val == null) return;
        widget.onSelected.call(val);
      },
    );
  }
}
