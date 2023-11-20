import 'package:flutter/widgets.dart';
import 'package:vbaseproject/product/widget/button/multiple_select_button.dart';

mixin MultipleSelectButtonMixin on State<MultipleSelectButton> {
  final ValueNotifier<List<MultipleSelectItem>> selectedItemsNotifier =
      ValueNotifier([]);

  /// Core items
  late final List<MultipleSelectItem> items;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  void addOrRemoveItem(MultipleSelectItem item) {
    final currentItems = selectedItemsNotifier.value.toList();
    if (currentItems.contains(item)) {
      currentItems.remove(item);
    } else {
      currentItems.add(item);
    }

    selectedItemsNotifier.value = currentItems;
    widget.onUpdatedSelectedItems.call(currentItems);
  }
}
