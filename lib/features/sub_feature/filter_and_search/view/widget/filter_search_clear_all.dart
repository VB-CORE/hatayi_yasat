part of '../filter_search_view.dart';

final class _FilterSearchClearAll extends ConsumerWidget {
  const _FilterSearchClearAll();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(filterWithSearchProvider).isSelectedItems;

    if (!isSelected) return const SizedBox();

    return TextButton(
      onPressed: () {
        ref.read(filterWithSearchProvider.notifier).clearAllSelection();
      },
      child: Row(
        children: [
          const Icon(Icons.delete_outline),
          Text(
            LocaleKeys.button_clearAllSelection.tr(
              args: [
                ref
                    .watch(filterWithSearchProvider)
                    .selectedItemsCount
                    .toString(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
