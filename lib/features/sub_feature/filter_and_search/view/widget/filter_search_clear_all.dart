part of '../filter_search_view.dart';

/// "Temizle" header action — only visible when at least one filter is
/// active. Resets the entire filter selection.
final class _FilterSearchClearAll extends ConsumerWidget {
  const _FilterSearchClearAll();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(filterWithSearchProvider).isSelectedItems;
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    if (!isSelected) {
      return const SizedBox.shrink();
    }

    return TextButton(
      key: const Key('filterClearAll'),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () =>
          ref.read(filterWithSearchProvider.notifier).clearAllSelection(),
      child: Text(
        LocaleKeys.component_filter_clear.tr(),
        style: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSecondaryFixed,
        ),
      ),
    );
  }
}
