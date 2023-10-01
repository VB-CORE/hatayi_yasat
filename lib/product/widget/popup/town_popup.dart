import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

class TownPopup extends ConsumerStatefulWidget {
  const TownPopup({
    required this.onSelected,
    super.key,
    this.initialItem,
  });

  final ValueChanged<TownModel> onSelected;
  final TownModel? initialItem;
  @override
  ConsumerState<TownPopup> createState() => _CategoryPopupState();
}

class _CategoryPopupState extends ConsumerState<TownPopup> {
  TownModel? _selectedItem;
  late final List<TownModel> items;

  @override
  void initState() {
    super.initState();
    items = ref.read(ProductProvider.provider).townItemsWithAll;
    _selectedItem = widget.initialItem ?? items.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: PopupMenuButton<TownModel>(
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(),
                ),
            ],
          ),
        ),
        itemBuilder: (context) {
          return items
              .map(
                (e) => PopupMenuItem<TownModel>(
                  value: e,
                  child: Text(e.displayName),
                ),
              )
              .toList();
        },
      ),
    );
  }

  void _onChanged(TownModel? value) {
    if (value == null) return;
    setState(() {
      _selectedItem = value;
    });
    widget.onSelected(value);
  }
}
