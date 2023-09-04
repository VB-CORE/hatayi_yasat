import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home/view/home_view.dart';
import 'package:vbaseproject/features/home/view/search/home_search_delegate.dart';
import 'package:vbaseproject/features/home/view_model/home_provider.dart';
import 'package:vbaseproject/features/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';

mixin HomeViewMixin on ConsumerState<HomeView> {
  void init(HomeViewModel viewModel) {
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
