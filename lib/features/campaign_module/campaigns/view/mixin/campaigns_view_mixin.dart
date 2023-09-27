import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view/campaigns_view.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view_model/campaigns_provider.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

final StateNotifierProvider<CampaignsViewModel, CampaignsState>
    _campaignsViewModel = StateNotifierProvider(
  (ref) => CampaignsViewModel(
    productProvider: ref.read(ProductProvider.provider.notifier),
    customService: FirebaseService(),
  ),
);

mixin CampaignsViewMixin
    on
        AutomaticKeepAliveClientMixin<CampaignsView>,
        ConsumerState<CampaignsView> {
  @override
  WidgetRef get ref;

  @override
  bool get wantKeepAlive => true;

  List<CampaignModel> get items =>
      ref.watch(_campaignsViewModel).campaignsItems;

  bool get isRequestSending =>
      ref.watch(_campaignsViewModel).isServiceRequestSending;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_campaignsViewModel.notifier).fetchNonExpiredItemsAndSave();
    });
  }

  Future<void> fetchNewItemsWithRefresh() async {
    await ref.read(_campaignsViewModel.notifier).fetchNonExpiredItemsAndSave();
  }
}
