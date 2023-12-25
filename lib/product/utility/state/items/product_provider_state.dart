import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
class ProductProviderState extends Equatable {
  const ProductProviderState({
    this.townItems = const [],
    this.storeItems = const [],
    this.developerItems = const [],
    this.agencyItems = const [],
    this.categoryItems = const [],
    this.campaignItems = const [],
    this.favoritePlaces = const [],
  });

  final List<TownModel> townItems;
  final List<StoreModel> storeItems;
  final List<DeveloperModel> developerItems;
  final List<SpecialAgencyModel> agencyItems;
  final List<CategoryModel> categoryItems;
  final List<CampaignModel> campaignItems;
  final List<StoreModel> favoritePlaces;

  @override
  List<Object> get props => [
        townItems,
        storeItems,
        developerItems,
        agencyItems,
        categoryItems,
        campaignItems,
        favoritePlaces,
      ];

  ProductProviderState copyWith({
    List<TownModel>? townItems,
    List<DeveloperModel>? developerItems,
    List<SpecialAgencyModel>? agencyItems,
    List<CategoryModel>? categoryItems,
    List<CampaignModel>? campaignItems,
    List<StoreModel>? favoritePlaces,
  }) {
    return ProductProviderState(
      townItems: townItems ?? this.townItems,
      developerItems: developerItems ?? this.developerItems,
      agencyItems: agencyItems ?? this.agencyItems,
      categoryItems: categoryItems ?? this.categoryItems,
      campaignItems: campaignItems ?? this.campaignItems,
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
    );
  }
}
