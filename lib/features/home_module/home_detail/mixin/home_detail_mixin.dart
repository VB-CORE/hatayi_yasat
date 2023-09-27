import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/utility/package/file_compress/image_compress_and_watermark.dart';

mixin HomeDetailMixin on State<HomeDetailView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> screenshotNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isClicked = ValueNotifier<bool>(false);

  late final StoreModel model;
  late final ImageCompressAndWaterMark imageCompressAndWaterMark;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    imageCompressAndWaterMark = ImageCompressAndWaterMark(model);
  }

  bool listenNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final newIsPinned = notification.metrics.pixels > 200;
      if (newIsPinned == isPinnedNotifier.value) return true;
      isPinnedNotifier.value = newIsPinned;
    }
    return true;
  }

  Future<void> captureAndShare() async {
    if (isClicked.value) return;
    _toggleIsClicked();
    _toggleScreenshot();
    await imageCompressAndWaterMark.capture();
    _toggleScreenshot();
    await imageCompressAndWaterMark.share().then((value) => _toggleIsClicked());
  }

  void _toggleIsClicked() {
    isClicked.value = !isClicked.value;
  }

  void _toggleScreenshot() {
    screenshotNotifier.value = !screenshotNotifier.value;
  }
}
