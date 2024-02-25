import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({
    required this.onSelected,
    super.key,
    this.items = const [],
    this.initialItem,
  });

  final List<CategoryModel> items;
  final ValueChanged<CategoryModel> onSelected;
  final CategoryModel? initialItem;
  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  CategoryModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: DropdownButtonFormField<CategoryModel>(
        validator: _check,
        isExpanded: true,
        items: widget.items
            .map(
              (e) => DropdownMenuItem<CategoryModel>(
                value: e,
                child: _DropdownTitle(e.displayName),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: LocaleKeys.requestCompany_category.tr(),
          labelStyle: context.general.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorCommon(context).whiteAndBlackForTheme,
          ),
        ),
        onChanged: _onChanged,
        value: _selectedItem,
      ),
    );
  }

  String? _check(CategoryModel? value) {
    if (value == null) {
      return LocaleKeys.validation_categoryEmpty.tr();
    }
    return null;
  }

  void _onChanged(CategoryModel? value) {
    if (value == null) return;
    setState(() {
      _selectedItem = value;
    });
    widget.onSelected(value);
  }
}

class _DropdownTitle extends StatelessWidget {
  const _DropdownTitle(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.labelLarge?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}
