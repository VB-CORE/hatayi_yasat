// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final items = await FirebaseService.getList<TownModel>(
      model: TownModel(),
      path: CollectionEnums.towns,
    );
    state = state.copyWith(townItems: items);
  }
}

@immutable
class ProductProviderState extends Equatable {
  const ProductProviderState({
    this.townItems = const [],
  });

  final List<TownModel> townItems;

  @override
  List<Object?> get props => [townItems];

  ProductProviderState copyWith({
    List<TownModel>? townItems,
  }) {
    return ProductProviderState(
      townItems: townItems ?? this.townItems,
    );
  }
}
