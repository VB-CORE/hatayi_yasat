import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/place_detail/view/place_detail_view.dart';

mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  final double patternHeightFactor = .25;

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
