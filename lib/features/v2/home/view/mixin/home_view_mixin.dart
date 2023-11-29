import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/home/view/home_view.dart';

mixin HomeViewMixin on ConsumerState<HomeView> {
  late final ScrollController customScrollController;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    customScrollController = ScrollController();
  }
}
