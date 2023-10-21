import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaign_details/campaign_details_view.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view/mixin/campaigns_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/place_shimmer_grid.dart';
import 'package:vbaseproject/product/package/slider/custom_slider.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/card/campaign_place_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

part 'widget/campaigns_grid_builder.dart';
part 'widget/campaigns_slider_builder.dart';

class CampaignsView extends ConsumerStatefulWidget {
  const CampaignsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CampaignsViewState();
}

class _CampaignsViewState extends ConsumerState<CampaignsView>
    with AppProviderMixin, AutomaticKeepAliveClientMixin, CampaignsViewMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => fetchNewItemsWithRefresh(),
        child: CustomScrollView(
          slivers: [
            _PageBody(
              onRefresh: () async => fetchNewItemsWithRefresh(),
              items: items,
              isRequestSending: isRequestSending,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({
    required this.items,
    required this.isRequestSending,
    required this.onRefresh,
  });
  final VoidCallback onRefresh;
  final List<CampaignModel> items;
  final bool isRequestSending;
  @override
  Widget build(BuildContext context) {
    if (isRequestSending) {
      return SliverFillRemaining(
        child: Padding(
          padding: const PagePadding.onlyTop(),
          child: PlaceShimmerGrid(gridDelegate: _gridDelegate),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        child: NotFoundLottie(
          title: LocaleKeys.notFound_campaign.tr(),
          onRefresh: onRefresh,
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        _SliderBuilder(
          items: items.take(AppConstants.kThree).toList(),
        ),
        _GridBuilder(
          items: items,
          gridDelegate: _gridDelegate,
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: WidgetSizes.spacingXxl12,
          ),
        ),
      ],
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount get _gridDelegate {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: AppConstants.kTwo,
      childAspectRatio: AppConstants.kThree / AppConstants.kFour,
    );
  }
}
