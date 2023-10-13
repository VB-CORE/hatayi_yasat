import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news/view/news_view.dart';
import 'package:vbaseproject/features/news_module/news/view_model/news_view_model.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

final StateNotifierProvider<NewsViewModel, NewsState> _newsViewModel =
    StateNotifierProvider(
  (ref) => NewsViewModel(
    productProvider: ref.read(ProductProvider.provider.notifier),
    customService: FirebaseCustomService(),
  ),
);

mixin NewsViewMixin
    on ConsumerState<NewsView>, AutomaticKeepAliveClientMixin<NewsView> {
  @override
  WidgetRef get ref;

  @override
  bool get wantKeepAlive => true;

  List<NewsModel> get items => ref.watch(_newsViewModel).newsItems;

  bool get isRequestSending =>
      ref.watch(_newsViewModel).isServiceRequestSending;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_newsViewModel.notifier).fetchNewsItemsAndSave();
    });
  }

  Future<void> fetchNewItemsWithRefresh() async {
    await ref.read(_newsViewModel.notifier).fetchNewsItemsAndSave();
  }
}
