part of '../container_markets_view.dart';

/// V3 container-market card — 100h mosaic-gradient hero with the district
/// pill (top-left) and shop-count chip (bottom-right), followed by name,
/// area, and an "İşletmeler / Yol tarifi" action row. Both actions surface
/// a "yakında" snackbar until the per-market shop list ships.
final class _ContainerMarketCard extends StatelessWidget {
  const _ContainerMarketCard({required this.market});

  final ContainerMarket market;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Material(
      color: colorScheme.secondary,
      borderRadius: CustomRadius.large,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: CustomRadius.large,
          border: Border.all(color: colorScheme.onPrimaryContainer),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CardHero(market: market),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    market.nameKey.tr(),
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const EmptyBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 13,
                        color: colorScheme.onSecondaryFixed,
                      ),
                      const EmptyBox(width: 4),
                      Expanded(
                        child: Text(
                          market.areaKey.tr(),
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: colorScheme.onSecondaryFixed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const EmptyBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _CardActionButton(
                          icon: Icons.storefront_rounded,
                          label: LocaleKeys.containerMarkets_shopsAction.tr(),
                          primary: true,
                          onTap: () => _showComingSoon(context),
                        ),
                      ),
                      const EmptyBox(width: 8),
                      _CardActionButton(
                        icon: Icons.directions_rounded,
                        label: LocaleKeys.containerMarkets_directionsAction
                            .tr(),
                        primary: false,
                        onTap: () => _showComingSoon(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primary,
        content: Text(
          LocaleKeys.containerMarkets_comingSoonBody.tr(),
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

final class _CardHero extends StatelessWidget {
  const _CardHero({required this.market});

  final ContainerMarket market;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Brand-locked mosaic gradient — every market reads as a mini
          // mozaik tile regardless of theme.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [market.accent, ColorsCustom.navy],
              ),
            ),
          ),
          const MosaicGrid(tileSize: 14, opacity: 0.32),
          Positioned(
            top: 10,
            left: 12,
            child: _DistrictPill(
              label: market.districtKey.tr(),
              accent: market.accent,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 12,
            child: _ShopCountPill(count: market.shopCount),
          ),
        ],
      ),
    );
  }
}

final class _DistrictPill extends StatelessWidget {
  const _DistrictPill({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // Always white pill so the district label reads against any
        // mosaic gradient.
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        child: Eyebrow(label, color: accent, fontSize: 10),
      ),
    );
  }
}

final class _ShopCountPill extends StatelessWidget {
  const _ShopCountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.storefront_rounded,
              size: 12,
              color: Color(0xFFFFFFFF),
            ),
            const EmptyBox(width: 5),
            Text(
              '$count ${LocaleKeys.containerMarkets_shopsAction.tr().toLowerCase()}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _CardActionButton extends StatelessWidget {
  const _CardActionButton({
    required this.icon,
    required this.label,
    required this.primary,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Material(
      color: primary ? colorScheme.primary : colorScheme.secondary,
      borderRadius: CustomRadius.medium,
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomRadius.medium,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: CustomRadius.medium,
            border: Border.all(
              color: primary
                  ? colorScheme.primary
                  : colorScheme.onPrimaryContainer,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: primary ? colorScheme.onPrimary : colorScheme.primary,
              ),
              const EmptyBox(width: 6),
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: primary ? colorScheme.onPrimary : colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
