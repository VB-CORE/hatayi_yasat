import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaign_details/campaign_details_view.dart';

mixin CampaignDetailsMixin on State<CampaignDetailsView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);
  late final CampaignModel campaignModel;

  @override
  void initState() {
    super.initState();
    campaignModel = widget.campaignModel;
  }

  bool listenNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final newIsPinned = notification.metrics.pixels > 200;
      if (newIsPinned == isPinnedNotifier.value) return true;
      isPinnedNotifier.value = newIsPinned;
    }
    return true;
  }
}
