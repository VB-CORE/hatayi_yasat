import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view/mixin/campaigns_view_mixin.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/card/campaign_place_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/utility/package/shimmer/place_shimmer_grid.dart';
import 'package:vbaseproject/product/utility/package/slider/custom_slider.dart';

part 'widget/campaigns_grid_builder.dart';
part 'widget/campaigns_slider_builder.dart';

class CampaignsView extends ConsumerStatefulWidget {
  const CampaignsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CampaignsViewState();
}

class _CampaignsViewState extends ConsumerState<CampaignsView>
    with AppProviderMixin, CampaignsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => fetchNewItemsWithRefresh(),
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              _PageBody(
                items: items,
                isRequestSending: isRequestSending,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageBody extends ConsumerWidget {
  const _PageBody({required this.items, required this.isRequestSending});
  final List<CampaignModel> items;
  final bool isRequestSending;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isRequestSending) {
      return const SliverFillRemaining(
        child: Padding(
          padding: PagePadding.onlyTop(),
          child: PlaceShimmerGrid(),
        ),
      );
    }

    if (items.isEmpty) {
      return const SliverFillRemaining(child: NotFoundLottie());
    }

    return SliverMainAxisGroup(
      slivers: [
        _SliderBuilder(
          items: items.take(AppConstants.kThree).toList(),
        ),
        _GridBuilder(
          items: items,
        ),
      ],
    );
  }
}
