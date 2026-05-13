part of '../filter_search_view.dart';

/// V2 section header for the categories block — eyebrow label on the
/// left, selected/total count on the right.
final class _FilterSearchCategoryHeader extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchCategoryHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = productState(ref).categoryItems;
    final selected = ref
        .watch(filterWithSearchProvider)
        .selectedCategories
        .length;
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(LocaleKeys.component_filter_categoriesEyebrow.tr()),
                const EmptyBox.xSmallHeight(),
                Text(
                  LocaleKeys.component_filter_categories.tr(),
                  style: V2Typography.display(
                    fontSize: 18,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            LocaleKeys.component_filter_selectedCount.tr(
              namedArgs: {
                'selected': selected.toString(),
                'total': categories.length.toString(),
              },
            ),
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: selected > 0
                  ? colorScheme.error
                  : colorScheme.onSecondaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
