part of '../filter_search_view.dart';

/// V2 section header for the districts block — eyebrow + DM-serif title
/// + selected/total badge, followed by a one-line hint.
final class _FilterSearchTownsHeader extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchTownsHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = productProvider(ref).regionalTowns;
    final selected = ref.watch(filterWithSearchProvider).selectedTowns.length;
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow(
                      LocaleKeys.component_filter_districtsEyebrow.tr(),
                      color: colorScheme.onSecondaryContainer,
                    ),
                    const EmptyBox.xSmallHeight(),
                    Text(
                      LocaleKeys.component_filter_districts.tr(),
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
                    'total': towns.length.toString(),
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
          const EmptyBox.xSmallHeight(),
          Text(
            LocaleKeys.component_filter_districtsHint.tr(),
            style: textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.5,
              color: colorScheme.onSecondaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
