part of '../chain_store_view.dart';

final class _MarketCard extends StatelessWidget {
  const _MarketCard({required this.market});

  final ChainStoreModel market;

  static const double _iconSize = WidgetSizes.spacingXxl7;
  static const double _iconTileSize = WidgetSizes.spacingXSs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: Semantics(
        button: true,
        label: market.name,
        child: InkWell(
          onTap: () => ChainStoreDetailRoute(
            marketId: market.documentId,
          ).go(context),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: context.appColors.ink100),
              boxShadow: AppShadows.card,
            ),
            padding: const PagePadding.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                Row(
                  spacing: AppSpacing.sm,
                  children: [
                    _MarketIcon(logoUrl: market.logoImageUrl),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralBodyTitle(
                            market.name,
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.start,
                          ),
                          if (market.description.isNotEmpty)
                            GeneralContentSmallTitle(
                              value: market.description,
                              maxLine: 1,
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      AppIcons.rightSelect,
                      color: context.appColors.ink300,
                    ),
                  ],
                ),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xxs,
                  children: [
                    _MarketChip(
                      label: LocaleKeys.chain_stores_shopCount.tr(
                        args: [(market.branches?.length ?? 0).toString()],
                      ),
                      color: context.appColors.coral,
                      icon: AppIcons.store,
                    ),
                    ?_hoursChip(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _hoursChip(BuildContext context) {
    final hours = WorkingHours.format(market.openHour, market.closeHour);
    if (hours == null) return null;

    return _MarketChip(
      label: hours,
      color: context.appColors.ink500,
      icon: AppIcons.timerOn,
    );
  }
}

final class _MarketIcon extends StatelessWidget {
  const _MarketIcon({required this.logoUrl});

  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _MarketCard._iconSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: logoUrl.isEmpty
            ? const _MosaicFallback()
            : CustomNetworkImage(imageUrl: logoUrl, fit: BoxFit.cover),
      ),
    );
  }
}

final class _MosaicFallback extends StatelessWidget {
  const _MosaicFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appColors.coral,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const MosaicBackground(
            showGradient: false,
            tileSize: _MarketCard._iconTileSize,
          ),
          Icon(AppIcons.store, color: context.appColors.surface),
        ],
      ),
    );
  }
}

final class _MarketChip extends StatelessWidget {
  const _MarketChip({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  static const double _backgroundOpacity = 0.1;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: _backgroundOpacity),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding:
            const PagePadding.horizontalVeryLowSymmetric() +
            const PagePadding.vertical6Symmetric(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xxs,
          children: [
            Icon(icon, color: color, size: AppIconSizes.smallX),
            GeneralContentSmallTitle(value: label, color: color),
          ],
        ),
      ),
    );
  }
}
