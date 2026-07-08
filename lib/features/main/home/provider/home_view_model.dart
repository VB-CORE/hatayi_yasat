import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/home_state.dart';
import 'package:lifeclient/product/model/enum/firebase_query_items.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
final class HomeViewModel extends _$HomeViewModel with ProjectDependencyMixin {
  @override
  HomeState build() {
    final categories = ref.read(productProviderState).categoryItems;
    final isHomeViewGrid =
        ref.read(productProviderState.notifier).isHomeViewGrid;
    return HomeState(
      categories: categories,
      isGridView: isHomeViewGrid,
    );
  }

  CollectionReference<StoreModel?> fetchApprovedCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.approvedApplications,
      StoreModel.empty(),
    );
  }

  Query<StoreModel?> fetchApprovedCollectionQuery() {
    final selectedCity = ref.watch(productProviderState).selectedCity;
    return buildApprovedQuery(
      cityId: selectedCity.documentId,
      categoryValues: state.categoryValues,
      townCodes: state.townCodes,
      sortingType: state.sortingType,
    );
  }

  /// Builds the approved-places query for the given axes. Category and town are
  /// server-side (`whereIn`); open-now/favorites are applied in memory by the
  /// view because they have no Firestore field.
  Query<StoreModel?> buildApprovedQuery({
    required String cityId,
    required Set<int> categoryValues,
    required Set<int> townCodes,
    required SortingTypes sortingType,
  }) {
    final reference = firebaseService.collectionReference(
      CollectionPaths.approvedApplications,
      StoreModel.empty(),
    );

    final filters = <Filter>[
      Filter(FirebaseQueryItems.cityId.name, isEqualTo: cityId),
      if (categoryValues.isNotEmpty)
        Filter(_categoryValueField, whereIn: categoryValues.toList()),
      if (townCodes.isNotEmpty)
        Filter(_townCodeField, whereIn: townCodes.toList()),
    ];

    final combined = switch (filters.length) {
      1 => filters[0],
      2 => Filter.and(filters[0], filters[1]),
      _ => Filter.and(filters[0], filters[1], filters[2]),
    };

    return reference.where(combined).orderBy(
          sortingType.field,
          descending: sortingType.descending,
        );
  }

  void changeHomeViewCardType() {
    state = state.copyWith(isGridView: !state.isGridView);
    ref.read(productProviderState.notifier).saveLatestGridViewType(
          isSelected: state.isGridView,
        );
  }

  Future<void> changeSortingType(SortingTypes type) async {
    if (state.sortingType == type) return;
    state = state.copyWith(sortingType: type);
    await _reloadPlaces();
  }

  /// Quick single-category selection from the home chip bar.
  /// [value] null clears the category filter ("Tümü").
  Future<void> selectSingleCategory(int? value) async {
    final next = value == null ? <int>{} : {value};
    if (setEquals(state.categoryValues, next)) return;
    state = state.copyWith(categoryValues: next);
    await _reloadPlaces();
  }

  Future<void> applyFilters({
    required Set<int> categoryValues,
    required Set<int> townCodes,
    required bool openNow,
    required bool favoritesOnly,
  }) async {
    state = state.copyWith(
      categoryValues: categoryValues,
      townCodes: townCodes,
      openNow: openNow,
      favoritesOnly: favoritesOnly,
    );
    await _reloadPlaces();
  }

  Future<void> clearFilters() async {
    if (!state.hasActiveFilters) return;
    state = state.copyWith(
      categoryValues: {},
      townCodes: {},
      openNow: false,
      favoritesOnly: false,
    );
    await _reloadPlaces();
  }

  /// Live result count for the filter sheet CTA. Uses the cheap aggregate count
  /// when there are no client-side axes; otherwise loads a bounded page and
  /// filters in memory.
  Future<int> countResults({
    required Set<int> categoryValues,
    required Set<int> townCodes,
    required bool openNow,
    required bool favoritesOnly,
  }) async {
    final selectedCity = ref.read(productProviderState).selectedCity;
    final query = buildApprovedQuery(
      cityId: selectedCity.documentId,
      categoryValues: categoryValues,
      townCodes: townCodes,
      sortingType: state.sortingType,
    );

    if (!openNow && !favoritesOnly) {
      final snapshot = await query.count().get();
      return snapshot.count ?? 0;
    }

    final snapshot = await query.limit(_clientFilterLimit).get();
    final models = snapshot.docs.map((e) => e.data()).whereType<StoreModel>();
    return filterClientSide(
      models,
      openNow: openNow,
      favoritesOnly: favoritesOnly,
    ).length;
  }

  /// Applies open-now / favorites predicates in memory.
  List<StoreModel> filterClientSide(
    Iterable<StoreModel> models, {
    required bool openNow,
    required bool favoritesOnly,
  }) {
    final favoriteIds = favoritesOnly
        ? ref
            .read(productProviderState)
            .favoritePlaces
            .map((e) => e.documentId)
            .toSet()
        : const <String>{};

    return models.where((model) {
      if (openNow && StoreModelHelper(model: model).isStoreOpen != true) {
        return false;
      }
      if (favoritesOnly && !favoriteIds.contains(model.documentId)) {
        return false;
      }
      return true;
    }).toList();
  }

  Future<void> _reloadPlaces() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(Durations.long2);
    state = state.copyWith(isLoading: false);
  }

  static const String _categoryValueField = 'category.value';
  static const String _townCodeField = 'townCode';
  static const int _clientFilterLimit = 300;
}
