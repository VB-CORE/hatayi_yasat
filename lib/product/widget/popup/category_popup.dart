import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

class CategoryPopup extends ConsumerStatefulWidget {
  const CategoryPopup({
    required this.onSelected,
    super.key,
    this.initialItem,
  });

  final ValueChanged<CategoryModel> onSelected;
  final CategoryModel? initialItem;
  @override
  ConsumerState<CategoryPopup> createState() => _CategoryPopupState();
}

class _CategoryPopupState extends ConsumerState<CategoryPopup> {
  CategoryModel? _selectedItem;
  late final List<CategoryModel> items;

  @override
  void initState() {
    super.initState();
    items = ref.read(ProductProvider.provider).categoryItemsWithAll;
    _selectedItem = widget.initialItem ?? items.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: PopupMenuButton<CategoryModel>(
        onSelected: _onChanged,
        initialValue: _selectedItem,
        child: Padding(
          padding: const PagePadding.onlyRightLow(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.filter_alt_outlined),
              if (_selectedItem != null)
                Text(
                  _selectedItem!.displayName,
                  overflow: TextOverflow.fade,
                  style: context.general.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorCommon(context).whiteAndBlackForTheme,
                  ),
                ),
            ],
          ),
        ),
        itemBuilder: (context) {
          return items
              .map(
                (e) => PopupMenuItem<CategoryModel>(
                  value: e,
                  child: Text(e.displayName),
                ),
              )
              .toList();
        },
      ),
    );
  }

  void _onChanged(CategoryModel? value) {
    if (value == null) return;
    setState(() {
      _selectedItem = value;
    });
    widget.onSelected(value);
  }
}
