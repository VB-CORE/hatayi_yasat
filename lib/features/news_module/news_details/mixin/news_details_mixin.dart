import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news_details/news_details_view.dart';

mixin NewsDetailsMixin on State<NewsDetailsView> {
  final ValueNotifier<bool> isPinnedNotifier = ValueNotifier<bool>(false);
  late final NewsModel newsModel;
  @override
  void initState() {
    super.initState();
    newsModel = widget.newsModel;
  }

  bool listenNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final newIsPinned = notification.metrics.pixels > 210;
      if (newIsPinned == isPinnedNotifier.value) return true;
      isPinnedNotifier.value = newIsPinned;
    }
    return true;
  }
}
