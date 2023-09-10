import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/feature/path_operation/custom_path_manager.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';

mixin HomeDetailMixin on State<HomeDetailView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);
  late final StoreModel model;

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> captureAndShare() async {
    final response = await screenshotController.capture();
    if (response == null) return;

    final file = await _makeFile(response, model);
    if (file == null) return;

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: '${model.name}${model.description}',
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

Future<File?> _makeFile(Uint8List response, StoreModel model) async {
  final customPathManager = CustomPathManager();
  final file = await customPathManager.writeByteToFile(
    response,
    '${model.name}-${model.id}.png',
  );
  return file;
}
