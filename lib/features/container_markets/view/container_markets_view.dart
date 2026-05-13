import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/features/container_markets/model/container_market.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/container_market_card.dart';

/// V3 Konteyner Çarşılar list. Hard-coded sample data today (see
/// [containerMarketSamples]); the Firestore-backed version will swap the
/// data source without changing the cards.
final class ContainerMarketsView extends StatelessWidget {
  const ContainerMarketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final markets = containerMarketSamples;
    final totalShops = markets.fold<int>(0, (sum, m) => sum + m.shopCount);

    return GeneralScaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.containerMarkets_title.tr(),
              style: V2Typography.display(
                fontSize: 22,
                color: colorScheme.primary,
              ),
            ),
            const EmptyBox(height: 2),
            Text(
              LocaleKeys.containerMarkets_subtitle.tr(
                namedArgs: {
                  'count': markets.length.toString(),
                  'total': totalShops.toString(),
                },
              ),
              style: context.general.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: colorScheme.onSecondaryFixed,
              ),
            ),
          ],
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        itemCount: markets.length,
        separatorBuilder: (_, _) => const EmptyBox(height: 12),
        itemBuilder: (context, i) => _ContainerMarketCard(market: markets[i]),
      ),
    );
  }
}
