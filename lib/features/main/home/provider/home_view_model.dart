import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/approved_place_query.dart';
import 'package:lifeclient/features/main/home/provider/home_state.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
final class HomeViewModel extends _$HomeViewModel with ProjectDependencyMixin {
  @override
  HomeState build() {
    final categories = ref.read(productProviderState).categoryItems;
    final isHomeViewGrid = ref
        .read(productProviderState.notifier)
        .isHomeViewGrid;
    return HomeState(
      categories: categories,
      isGridView: isHomeViewGrid,
    );
  }

  CollectionReference<StoreModel?> fetchApprovedCollectionReference() {
    return firestoreService.collectionReference(
      CollectionPaths.approvedApplications,
      StoreModel.empty(),
    );
  }

  Query<StoreModel?> fetchApprovedCollectionQuery() {
    // read: watch olursa favori degisimi bu provider'i yeniden kurar ve
    // secili filtreler sifirlanir. Sehir degisimini view zaten dinliyor.
    final selectedCity = ref.read(productProviderState).selectedCity;
    return ApprovedPlaceQuery(
      cityId: selectedCity.documentId,
      categoryValues: state.categoryValues,
      townCodes: state.townCodes,
      sortingType: state.sortingType,
    ).build(fetchApprovedCollectionReference());
  }

  ApprovedPlaceQuery draftQuery({
    required Set<int> categoryValues,
    required Set<int> townCodes,
  }) {
    return ApprovedPlaceQuery(
      cityId: ref.read(productProviderState).selectedCity.documentId,
      categoryValues: categoryValues,
      townCodes: townCodes,
      sortingType: state.sortingType,
    );
  }

  void changeHomeViewCardType() {
    state = state.copyWith(isGridView: !state.isGridView);
    ref
        .read(productProviderState.notifier)
        .saveLatestGridViewType(
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
  Future<FirestoreResult<int>> countResults(
    ApprovedPlaceQuery placeQuery, {
    required bool openNow,
    required bool favoritesOnly,
  }) async {
    final query = placeQuery.build(fetchApprovedCollectionReference());

    if (!openNow && !favoritesOnly) {
      return firestoreService.countQuery(query);
    }

    final result = await firestoreService.getListFromQuery(
      query.limit(_clientFilterLimit),
    );
    return switch (result) {
      FirebaseSuccess(:final data) => FirebaseSuccess(
        filterClientSide(
          data,
          openNow: openNow,
          favoritesOnly: favoritesOnly,
        ).length,
      ),
      FirebaseFailure(:final error, :final message) => FirebaseFailure(
        error,
        message: message,
      ),
    };
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

  static const int _clientFilterLimit = 300;
}
