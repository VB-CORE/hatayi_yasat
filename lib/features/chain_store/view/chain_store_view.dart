import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/chain_store/provider/chain_store_provider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/working_hours.dart';
import 'package:lifeclient/product/widget/app_bar/discover_section_app_bar.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/market_card.dart';

@immutable
final class ChainStoreView extends ConsumerWidget {
  const ChainStoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chainStoreProviderProvider);

    return GeneralScaffold(
      appBar: DiscoverSectionAppBar(
        title: LocaleKeys.chain_stores_title,
        subtitle: LocaleKeys.chain_stores_subtitle.tr(
          args: [
            state.chainStores.length.toString(),
            state.totalShopCount.toString(),
          ],
        ),
        accentColor: context.appColors.coral,
      ),
      body: const _ChainStoreListWidget(),
    );
  }
}

final class _ChainStoreListWidget extends ConsumerWidget {
  const _ChainStoreListWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(chainStoreProviderProvider.notifier)
        .fetchChainStoreCollectionReference();

    return GeneralFirestoreListView<ChainStoreModel>(
      query: query,
      onRetry: () {},
      emptyBuilder: (context) => GeneralNotFoundWidget(
        title: LocaleKeys.notFound_chainStore.tr(),
      ),
      itemBuilder: (context, model) {
        return Padding(
          padding:
              const PagePadding.horizontal16Symmetric() +
              const PagePadding.vertical8Symmetric(),
          child: _MarketCard(market: model),
        );
      },
    );
  }
}
