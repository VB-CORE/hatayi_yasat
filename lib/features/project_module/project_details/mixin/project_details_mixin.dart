import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/project_module/project_details/project_details_view.dart';

mixin ProjectDetailsMixin on State<ProjectDetailsView> {
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
