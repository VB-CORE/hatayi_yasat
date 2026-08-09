part of '../chain_store_detail_view.dart';

final class _MarketHero extends StatelessWidget {
  const _MarketHero({required this.market});

  final ChainStoreModel market;

  static const double _heroTileSize = WidgetSizes.spacingXsMid;
  static const double _heroTileOpacity = 0.16;

  @override
  Widget build(BuildContext context) {
    final accent = context.appColors.coral;

    return ColoredBox(
      color: accent,
      child: Stack(
        children: [
          const Positioned.fill(
            child: MosaicBackground(
              showGradient: false,
              tileSize: _heroTileSize,
              tileOpacity: _heroTileOpacity,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const PagePadding.all(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xs,
                children: [
                  const _HeroBackButton(),
                  GeneralContentTitle(
                    value: market.name,
                    color: context.appColors.white,
                  ),
                  GeneralContentSmallTitle(
                    value: _metaLine(),
                    color: context.appColors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _metaLine() {
    final parts = [
      if (market.description.isNotEmpty) market.description,
      ?_hours,
      LocaleKeys.chain_stores_shopCount.tr(
        args: [(market.branches?.length ?? 0).toString()],
      ),
    ];

    return parts.join(' · ');
  }

  String? get _hours => WorkingHours.format(market.openHour, market.closeHour);
}

final class _HeroBackButton extends StatelessWidget {
  const _HeroBackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: context.pop,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        padding: EdgeInsets.zero,
        icon: Icon(AppIcons.backIos, color: context.appColors.white),
      ),
    );
  }
}
