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
final class ChainStoreDetailView extends ConsumerWidget {
  const ChainStoreDetailView({required this.marketId, super.key});

  final String marketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chainStoreProviderProvider);

    if (state.isError) {
      return GeneralScaffold(
        body: SafeArea(
          child: ErrorRetryView(
            onRetry: ref.read(chainStoreProviderProvider.notifier).fetchMarkets,
          ),
        ),
      );
    }

    if (state.isFetching) {
      return GeneralScaffold(body: const SafeArea(child: SkeletonList()));
    }

    final market = state.marketById(marketId);
    if (market == null) {
      return GeneralScaffold(
        body: SafeArea(
          child: EmptyStateView(
            icon: AppIcons.store,
            title: LocaleKeys.chain_stores_notFoundTitle.tr(),
            description: LocaleKeys.chain_stores_notFoundDescription.tr(),
            iconBackgroundColor: context.appColors.ink25,
            iconColor: context.appColors.ink400,
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _MarketHero(market: market),
          Expanded(child: _ShopList(shops: market.branches ?? const [])),
        ],
      ),
    );
  }
}

final class _ShopList extends StatelessWidget {
  const _ShopList({required this.shops});

  final List<StoreModel> shops;

  @override
  Widget build(BuildContext context) {
    if (shops.isEmpty) {
      return EmptyStateView(
        icon: AppIcons.search,
        title: LocaleKeys.chain_stores_emptyTitle.tr(),
        description: LocaleKeys.chain_stores_emptyDescription.tr(),
        iconBackgroundColor: context.appColors.ink25,
        iconColor: context.appColors.ink400,
      );
    }

    return ListView.builder(
      padding:
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.onlyTopLow(),
      itemCount: shops.length + _headerOnly,
      itemBuilder: (context, index) {
        if (index == 0) return _ShopListHeader(count: shops.length);

        return _ShopRow(shop: shops[index - 1]);
      },
    );
  }

  static const int _headerOnly = 1;
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
