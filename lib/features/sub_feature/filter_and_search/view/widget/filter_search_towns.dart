part of '../filter_search_view.dart';

/// V2 district list — each row is a tappable navy-bordered card with a
/// custom square checkbox that fills navy when the district is part of
/// the active filter.
final class _FilterSearchTowns extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchTowns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = productProvider(ref).regionalTowns;
    final selectedItems = ref.watch(filterWithSearchProvider).selectedTowns;
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    if (towns.isEmpty) {
      return Padding(
        padding: const PagePadding.horizontalLowSymmetric(),
        child: Text(
          LocaleKeys.component_filter_noDistricts.tr(),
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSecondaryFixed,
          ),
        ),
      );
    }

    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: Column(
        children: [
          for (final town in towns)
            _DistrictRow(
              town: town.toTownModel,
              isActive: selectedItems.contains(town.toTownModel),
              onTap: () => ref
                  .read(filterWithSearchProvider.notifier)
                  .updateSelectedDistrict(town.toTownModel),
            ),
        ],
      ),
    );
  }
}

final class _DistrictRow extends StatelessWidget {
  const _DistrictRow({
    required this.town,
    required this.isActive,
    required this.onTap,
  });

  final TownModel town;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isActive
            ? colorScheme.primary.withValues(alpha: 0.06)
            : colorScheme.secondary,
        borderRadius: CustomRadius.medium,
        child: InkWell(
          onTap: onTap,
          borderRadius: CustomRadius.medium,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: CustomRadius.medium,
              border: Border.all(
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.onPrimaryContainer,
              ),
            ),
            child: Row(
              children: [
                _DistrictCheckbox(isActive: isActive),
                const EmptyBox(width: 12),
                Expanded(
                  child: Text(
                    town.displayName,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _DistrictCheckbox extends StatelessWidget {
  const _DistrictCheckbox({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isActive ? colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isActive
              ? colorScheme.primary
              : colorScheme.onPrimaryContainer,
          width: 2,
        ),
      ),
      child: isActive
          ? Icon(
              Icons.check_rounded,
              size: 14,
              color: colorScheme.onPrimary,
            )
          : null,
    );
  }
}
