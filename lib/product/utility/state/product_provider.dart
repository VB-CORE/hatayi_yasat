// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/model/firebase/town_model.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

class ProductProvider extends StateNotifier<ProductProviderState> {
  ProductProvider() : super(const ProductProviderState());

  static final provider =
      StateNotifierProvider<ProductProvider, ProductProviderState>((_) {
    return ProductProvider();
  });

  Future<void> fetchDistrictAndSaveSession() async {
    final items = await FirebaseService().getList<TownModel>(
      model: TownModel(),
      path: CollectionEnums.towns,
    );
    state = state.copyWith(townItems: items);
  }

  void saveCompanies(List<StoreModel> items) {
    state = state.copyWith(items: items);
  }

  String fetchTownFromCode(int? code) {
    return state.townItems
            .firstWhereOrNull(
              (element) => element.code == code,
            )
            ?.name ??
        '';
  }
}

@immutable
class ProductProviderState extends Equatable {
  const ProductProviderState({
    this.townItems = const [],
    this.items = const [],
  });

  final List<TownModel> townItems;
  final List<StoreModel> items;

  @override
  List<Object> get props => [townItems, items];

  ProductProviderState copyWith({
    List<TownModel>? townItems,
    List<StoreModel>? items,
  }) {
    return ProductProviderState(
      townItems: townItems ?? this.townItems,
      items: items ?? this.items,
    );
  }
}
