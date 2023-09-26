import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod/riverpod.dart';

import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required ProductProvider productProvider,
    required CustomService customService,
  })  : _productProvider = productProvider,
        _customService = customService,
        super(
          const HomeState(isServiceRequestSending: true),
        );

  final ProductProvider _productProvider;
  final CustomService _customService;

  List<StoreModel> _allItems = [];
  Future<void> fetchAllItemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);
    final items = await _customService.getList<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
    );

    _productProvider.saveStores(items);
    state = state.copyWith(
      isServiceRequestSending: false,
      items: items,
    );
    _allItems = items;
  }

  void filter(TownModel? value) {
    if (value == null || value.code == kErrorNumber) {
      if (_allItems != state.items) {
        state = state.copyWith(items: _allItems);
      }
      return;
    }
    final filteredItems =
        _allItems.where((element) => element.townCode == value.code).toList();
    state = state.copyWith(items: filteredItems);
  }
}

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.isServiceRequestSending = false,
    this.items = const [],
  });

  final bool isServiceRequestSending;
  final List<StoreModel> items;

  bool get isEnabled => !isServiceRequestSending && items.isNotEmpty;

  @override
  List<Object?> get props => [isServiceRequestSending, items];

  HomeState copyWith({
    bool? isServiceRequestSending,
    List<StoreModel>? items,
  }) {
    return HomeState(
      isServiceRequestSending:
          isServiceRequestSending ?? this.isServiceRequestSending,
      items: items ?? this.items,
    );
  }
}
