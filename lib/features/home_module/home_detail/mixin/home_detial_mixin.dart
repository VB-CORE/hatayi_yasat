import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';

mixin HomeDetailMixin on State<HomeDetailView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);
  late final StoreModel model;

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> captureAndShare() async {
    final response = await screenshotController.capture();
    if (response == null) return;

    await Share.shareXFiles(
      [XFile.fromData(response)],
      text: model.name,
      subject: model.description,
    );
  }

  @override
  void initState() {
    super.initState();
    model = widget.model;
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
