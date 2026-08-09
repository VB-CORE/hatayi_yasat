import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/chain_store/provider/chain_store_provider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/utility/working_hours.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/general/error_retry_view.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/detail_action_row.dart';
import 'package:lifeclient/product/widget/sheet/detail_sheet.dart';
import 'package:lifeclient/product/widget/skeleton/skeleton_list.dart';

part 'widget/market_hero.dart';
part 'widget/shop_row.dart';
part 'widget/shop_sheet.dart';

@immutable
final class ChainStoreDetailView extends StatelessWidget {
  const ChainStoreDetailView({required this.marketId, super.key});

  final String marketId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body(marketId: marketId));
  }
}

final class _Body extends ConsumerWidget {
  const _Body({required this.marketId});

  final String marketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chainStoreProviderProvider);

    if (state.isError) {
      return SafeArea(
        child: ErrorRetryView(
          onRetry: ref.read(chainStoreProviderProvider.notifier).fetchMarkets,
        ),
      );
    }

    if (state.isFetching) {
      return const SafeArea(child: SkeletonList());
    }

    final market = state.marketById(marketId);
    if (market == null) {
      return SafeArea(
        child: EmptyStateView(
          icon: AppIcons.store,
          title: LocaleKeys.chain_stores_notFoundTitle.tr(),
          description: LocaleKeys.chain_stores_notFoundDescription.tr(),
          iconBackgroundColor: context.appColors.ink25,
          iconColor: context.appColors.ink400,
        ),
      );
    }

    return _MarketDetail(market: market);
  }
}

final class _MarketDetail extends StatelessWidget {
  const _MarketDetail({required this.market});

  final ChainStoreModel market;

  @override
  Widget build(BuildContext context) {
    final shops = market.branches ?? const <StoreModel>[];

    if (shops.isEmpty) {
      return Column(
        children: [
          _MarketHero(market: market),
          Expanded(
            child: EmptyStateView(
              icon: AppIcons.search,
              title: LocaleKeys.chain_stores_emptyTitle.tr(),
              description: LocaleKeys.chain_stores_emptyDescription.tr(),
              iconBackgroundColor: context.appColors.ink25,
              iconColor: context.appColors.ink400,
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _MarketHero(market: market)),
        SliverPadding(
          padding:
              const PagePadding.horizontal16Symmetric() +
              const PagePadding.onlyTopLow(),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(child: _ShopListHeader(count: shops.length)),
              SliverList.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) => _ShopRow(shop: shops[index]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final class _ShopListHeader extends StatelessWidget {
  const _ShopListHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: GeneralContentSmallTitle(
        value: LocaleKeys.chain_stores_detailSubtitle.tr(
          args: [count.toString()],
        ),
      ),
    );
  }
}
