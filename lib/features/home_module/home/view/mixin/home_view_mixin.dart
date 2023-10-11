import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home/view/home_view.dart';
import 'package:vbaseproject/features/home_module/home/view/search/home_search_delegate.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_state.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_view_model.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_utility.dart';

mixin HomeViewMixin
    on AutomaticKeepAliveClientMixin<HomeView>, ConsumerState<HomeView> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController customScrollController = ScrollController();

  void init(HomeViewModel viewModel) {
    MessagingUtility.init();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.fetchAllItemsAndSave();
    });
  }

  Future<void> searchPressed(HomeState state) async {
    final items = state.items;
    final response = await showSearch<StoreModel>(
      context: context,
      delegate: HomeSearchDelegate(items: items),
    );
    if (response == null) return;
    if (!mounted) return;
    await context.route.navigateToPage(
      HomeDetailView(model: response),
    );
  }

  Future<void> fetchNewItemsWithRefresh(HomeViewModel viewModel) async {
    await viewModel.fetchAllItemsAndSave();
  }
}
