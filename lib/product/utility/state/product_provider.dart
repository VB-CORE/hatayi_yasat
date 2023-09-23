// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

class ProductProvider extends StateNotifier<ProductProviderState> {
  ProductProvider() : super(const ProductProviderState());

  static final provider =
      StateNotifierProvider<ProductProvider, ProductProviderState>((_) {
    return ProductProvider();
  });

  Future<void> fetchDistrictAndSaveSession() async {
    final items = await FirebaseService().getList<TownModel>(
      model: TownModel(),
      path: CollectionPaths.towns,
    );
    state = state.copyWith(townItems: items);
  }

  Future<void> fetchDevelopersAndAgency() async {
    final devItems = await FirebaseService().getList(
      model: DeveloperModel(),
      path: CollectionPaths.developers,
    );
    final agencyItems = await FirebaseService().getList(
      model: SpecialAgencyModel(),
      path: CollectionPaths.specialAgency,
    );
    state = state.copyWith(
      developerItems: devItems,
      agencyItems: agencyItems,
    );
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
    this.developerItems = const [],
    this.agencyItems = const [],
  });

  final List<TownModel> townItems;
  final List<StoreModel> items;
  final List<DeveloperModel> developerItems;
  final List<SpecialAgencyModel> agencyItems;

  @override
  List<Object> get props => [
        townItems,
        items,
        developerItems,
        agencyItems,
      ];

  ProductProviderState copyWith({
    List<TownModel>? townItems,
    List<StoreModel>? items,
    List<DeveloperModel>? developerItems,
    List<SpecialAgencyModel>? agencyItems,
  }) {
    return ProductProviderState(
      townItems: townItems ?? this.townItems,
      items: items ?? this.items,
      developerItems: developerItems ?? this.developerItems,
      agencyItems: agencyItems ?? this.agencyItems,
    );
  }
}
