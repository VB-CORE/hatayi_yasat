part of '../filter_search_view.dart';

/// V2 sticky CTA at the bottom of the filter sheet. Pushes the result
/// route only when at least one filter is active; otherwise stays
/// disabled (low-contrast surface) so the user knows there's nothing to
/// run yet.
final class _FilterSearchButton extends ConsumerWidget {
  const _FilterSearchButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final provider = ref.watch(filterWithSearchProvider);
    final isEnabled = provider.isSelectedItems;
    final count = provider.selectedItemsCount;

    return Material(
      color: colorScheme.secondary,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: Material(
              color: isEnabled
                  ? colorScheme.primary
                  : colorScheme.onPrimaryFixed,
              borderRadius: CustomRadius.medium,
              child: InkWell(
                key: const Key('filterShowResultsButton'),
                onTap: isEnabled
                    ? () => FilterResultRoute(
                        FilterSelected(
                          selectedCategories: provider.selectedCategories,
                          selectedTowns: provider.selectedTowns,
                        ),
                      ).push<void>(context)
                    : null,
                borderRadius: CustomRadius.medium,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count > 0
                            ? '${LocaleKeys.component_filter_showResults.tr()} ($count)'
                            : LocaleKeys.component_filter_showResults.tr(),
                        style: textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isEnabled
                              ? colorScheme.onPrimary
                              : colorScheme.onSecondaryFixed,
                        ),
                      ),
                      const EmptyBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: isEnabled
                            ? colorScheme.onPrimary
                            : colorScheme.onSecondaryFixed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
