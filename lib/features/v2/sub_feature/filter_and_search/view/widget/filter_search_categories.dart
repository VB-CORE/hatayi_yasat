part of '../filter_search_view.dart';

final class _FilterSearchCategories extends ConsumerWidget {
  const _FilterSearchCategories();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.read(ProductProvider.provider).categoryItemsWithAll;
    final items = categories
        .map((e) => MultipleSelectItem(title: e.displayName, id: e.documentId))
        .toList();
    return Expanded(
      flex: 2,
      child: MultipleSelectButton(
        items: items,
        onUpdatedSelectedItems: (items) {
          ref
              .read(filterWithSearchProvider.notifier)
              .updateSelectedCategory(items);
        },
      ),
    );
  }
}
