import 'package:flutter/material.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/widget/package/file_compress/image_compress_and_watermark.dart';

mixin HomeDetailMixin on State<HomeDetailView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isCapturedScreenShotNotifier =
      ValueNotifier<bool>(false);

  late final StoreModel model;
  late final ImageCompressAndWaterMark imageCompressAndWaterMark;

  Future<void> captureAndShare() async {
    await imageCompressAndWaterMark.captureAndShare();
  }

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
}
