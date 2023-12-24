part of '../filter_search_view.dart';

final class _FilterSearchClearAll extends ConsumerWidget {
  const _FilterSearchClearAll();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPageSwitch(
      firstChild: TextButton(
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
      ),
      secondChild: const SizedBox(),
      crossFadeState: ref.watch(filterWithSearchProvider).isSelectedItems
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}
