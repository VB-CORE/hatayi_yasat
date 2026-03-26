import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

class ProductComboBox<T extends ProductDropDownModel> extends StatefulWidget {
  const ProductComboBox({
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    super.key,
    this.initialItem,
  });
  final List<T> items;

  final ValueChanged<T?> onChanged;
  final String hintText;
  final String? Function(T?) validator;
  final T? initialItem;

  @override
  State<ProductComboBox<T>> createState() => _ProductComboBoxState<T>();
}

class _ProductComboBoxState<T extends ProductDropDownModel>
    extends State<ProductComboBox<T>> {
  T? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.general.colorScheme.onPrimaryFixed,
        border: Border.all(
          color: context.general.colorScheme.onPrimaryContainer,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(WidgetSizes.spacingXxs),
        ),
      ),
      child: Padding(
        padding: const PagePadding.allVeryLow(),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            dropdownColor: context.general.colorScheme.secondary,
            decoration: const InputDecoration.collapsed(hintText: ''),
            initialValue: selectedItem,
            hint: Text(
              widget.hintText,
              style: context.general.textTheme.bodyMedium?.copyWith(
                color: context.general.colorScheme.onSecondaryFixed,
              ),
            ),
            style: context.general.textTheme.bodyMedium?.copyWith(
              color: context.general.colorScheme.onSurface,
            ),
            isExpanded: true,
            borderRadius: context.border.lowBorderRadius,
            validator: widget.validator,
            items: widget.items
                .map((e) => _ProductDropdownItem(item: e))
                .toList(),
            onChanged: (value) {
              selectItem(value);
              widget.onChanged(value);
            },
          ),
        ),
      ),
    );
  }

  void selectItem(T? value) {
    setState(() {
      selectedItem = value;
    });
  }
}

class _ProductDropdownItem<T extends ProductDropDownModel>
    extends DropdownMenuItem<T> {
  _ProductDropdownItem({required T item})
    : super(
        child: Padding(
          padding: const PagePadding.horizontalVeryLowSymmetric(),
          child: Text(item.name ?? ''),
        ),
        value: item,
      );
}

mixin ProductDropDownModel {
  String? get name;
}
