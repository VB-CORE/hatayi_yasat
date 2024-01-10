part of '../filter_search_view.dart';

final class _FilterSearchCategories extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchCategories();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = productState(ref).categoryItems;
    final items = categories
        .map((e) => MultipleSelectItem(title: e.displayName, id: e.documentId))
        .toList();

    return MultipleSelectButton(
      items: items,
      selectedItems: ref.watch(filterWithSearchProvider).selectedCategories,
      onUpdatedSelectedItems: (items) {
        ref
            .read(filterWithSearchProvider.notifier)
            .updateSelectedCategory(items);
      },
    );
  }
}
