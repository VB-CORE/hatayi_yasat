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

  Future<void> fetchCategories() async {
    final items = await FirebaseService().getList(
      model: const CategoryModel.empty(),
      path: CollectionPaths.categories,
    );
    state = state.copyWith(categoryItems: items);
  }

  void saveStores(List<StoreModel> storeItems) {
    state = state.copyWith(storeItems: storeItems);
  }

  void saveCampaigns(List<CampaignModel> campaignItems) {
    state = state.copyWith(campaignItems: campaignItems);
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
    this.storeItems = const [],
    this.developerItems = const [],
    this.agencyItems = const [],
    this.categoryItems = const [],
    this.campaignItems = const [],
  });

  final List<TownModel> townItems;
  final List<StoreModel> storeItems;
  final List<DeveloperModel> developerItems;
  final List<SpecialAgencyModel> agencyItems;
  final List<CategoryModel> categoryItems;
  final List<CampaignModel> campaignItems;

  @override
  List<Object> get props => [
        townItems,
        storeItems,
        developerItems,
        agencyItems,
        categoryItems,
        campaignItems,
      ];

  ProductProviderState copyWith({
    List<TownModel>? townItems,
    List<StoreModel>? storeItems,
    List<DeveloperModel>? developerItems,
    List<SpecialAgencyModel>? agencyItems,
    List<CategoryModel>? categoryItems,
    List<CampaignModel>? campaignItems,
  }) {
    return ProductProviderState(
      townItems: townItems ?? this.townItems,
      storeItems: storeItems ?? this.storeItems,
      developerItems: developerItems ?? this.developerItems,
      agencyItems: agencyItems ?? this.agencyItems,
      categoryItems: categoryItems ?? this.categoryItems,
      campaignItems: campaignItems ?? this.campaignItems,
    );
  }
}
