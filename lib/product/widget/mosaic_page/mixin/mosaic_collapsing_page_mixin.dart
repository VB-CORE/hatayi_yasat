import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/mosaic_page/view/mosaic_collapsing_page.dart';

mixin MosaicCollapsingPageMixin on State<MosaicCollapsingPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
