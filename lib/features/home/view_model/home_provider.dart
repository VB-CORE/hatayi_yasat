import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';
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
  Future<void> fetchAllItemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);
    final items = await _customService.getList<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionEnums.approvedApplications,
    );

    _productProvider.saveCompanies(items);
    state = state.copyWith(
      isServiceRequestSending: false,
      items: items,
    );
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
