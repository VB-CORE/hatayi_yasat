import 'package:flutter/widgets.dart';
import 'package:vbaseproject/product/widget/button/multiple_select_button.dart';

mixin MultipleSelectButtonMixin on State<MultipleSelectButton> {
  final ValueNotifier<List<MultipleSelectItem>> selectedItemsNotifier =
      ValueNotifier([]);

  @override
  void didUpdateWidget(covariant MultipleSelectButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (selectedItemsNotifier.value != widget.selectedItems) {
      selectedItemsNotifier.value = widget.selectedItems;
    }
  }

  /// Core items
  late final List<MultipleSelectItem> items;

  late final ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();
    items = widget.items;
    _scrollController = ScrollController();
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
