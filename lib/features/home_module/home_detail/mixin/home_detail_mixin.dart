import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/feature/path_operation/custom_path_manager.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/widget/package/image_manipulation/image_manipulation.dart';

mixin HomeDetailMixin on State<HomeDetailView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);
  late final StoreModel model;
  late final File? screenShot;
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _capture() async {
    final response = await screenshotController.capture();
    if (response == null) return;
    screenShot = await _makeFile(response, model);
  }

  Future<void> share() async {
    if (screenShot == null) return;
    await Share.shareXFiles(
      [XFile(screenShot!.path)],
      subject: '${model.name}${model.description}',
    );
  }

  @override
  void initState() {
    super.initState();
    model = widget.model;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _capture();
    });
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

Future<File?> _makeFile(Uint8List response, StoreModel model) async {
  final customPathManager = CustomPathManager();
  final file = await customPathManager.writeByteToFile(
    response,
    '${model.name}-${model.id}.png',
  );
  final imageWithWatermark =
      await ImageManipulation.instance?.addWatermark(file: file);
  return imageWithWatermark;
}
