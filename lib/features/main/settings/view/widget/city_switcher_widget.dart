part of '../settings_view.dart';

/// V2 ŞEHİR card — surfaces every regional city as an inline row with a
/// mosaic-icon tile, name, description, and a navy radio indicator on the
/// right. Tapping a row updates the global `productProvider` city
/// selection and invalidates the home feed so it refetches under the new
/// scope.
final class _CitySwitcherWidget extends ConsumerWidget {
  const _CitySwitcherWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final state = ref.watch(ProjectDependencyItems.productProviderState);
    final cities = state.regionalCityItems;
    final selected = state.selectedCity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const PagePadding.horizontalSymmetric(),
          child: Material(
            color: colorScheme.secondary,
            borderRadius: CustomRadius.large,
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: CustomRadius.large,
                border: Border.all(color: colorScheme.onPrimaryContainer),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < cities.length; i++)
                    _CityRow(
                      key: Key('cityRow_${cities[i].documentId}'),
                      city: cities[i],
                      isActive: cities[i].documentId == selected.documentId,
                      isLast: i == cities.length - 1,
                      onTap: () => _selectCity(ref, cities[i]),
                    ),
                  if (cities.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        LocaleKeys.settingsV2_cityActiveTitle.tr(),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSecondaryFixed,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            LocaleKeys.settingsV2_cityChangeHint.tr(),
            style: textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.5,
              color: colorScheme.onSecondaryFixed,
            ),
          ),
        ),
      ],
    );
  }

  void _selectCity(WidgetRef ref, RegionalCityModel city) {
    final current = ref
        .read(ProjectDependencyItems.productProviderState)
        .selectedCity;
    if (current.documentId == city.documentId) return;
    ref
        .read(ProjectDependencyItems.productProviderState.notifier)
        .saveSelectedCity(city);
    ref.invalidate(homeViewModelProvider);
  }
}

final class _CityRow extends StatelessWidget {
  const _CityRow({
    required this.city,
    required this.isActive,
    required this.isLast,
    required this.onTap,
    super.key,
  });

  final RegionalCityModel city;
  final bool isActive;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast
                  ? Colors.transparent
                  : colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            _CityIcon(name: city.name),
            const EmptyBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (city.description.isNotEmpty) ...[
                    const EmptyBox(height: 2),
                    Text(
                      city.description,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: colorScheme.onSecondaryFixed,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            _CityRadio(isActive: isActive),
          ],
        ),
      ),
    );
  }
}

/// Mosaic-tile city avatar. Builds a 44×44 rounded square with a coral or
/// teal gradient based on the city's name hash, overlaid with the mozaik
/// grid so each city reads as a "mini Hatay tile" in the picker.
final class _CityIcon extends StatelessWidget {
  const _CityIcon({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final isTeal = name.toLowerCase().startsWith('mer');
    // Brand-locked tile so the city card visually matches the V2 design
    // even in dark mode — the mosaic icon is part of the brand identity.
    final colors = isTeal
        ? const [ColorsCustom.teal, ColorsCustom.teal700]
        : const [ColorsCustom.coral, ColorsCustom.coral700];
    return ClipRRect(
      borderRadius: CustomRadius.medium,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
              ),
            ),
            const MosaicGrid(tileSize: 6, opacity: 0.38),
            const Center(
              child: Icon(
                Icons.location_city_rounded,
                size: 22,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _CityRadio extends StatelessWidget {
  const _CityRadio({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? colorScheme.primary : Colors.transparent,
        border: Border.all(
          color: isActive
              ? colorScheme.primary
              : colorScheme.onPrimaryContainer,
          width: 2,
        ),
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.onPrimary,
                ),
              ),
            )
          : null,
    );
  }
}
