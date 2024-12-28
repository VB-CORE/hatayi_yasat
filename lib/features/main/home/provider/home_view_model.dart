import 'package:cloud_firestore/cloud_firestore.dart';
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
    final query = firebaseService
        .collectionReference(
          CollectionPaths.approvedApplications,
          StoreModel.empty(),
        )
        .where(
          FirebaseQueryItems.cityId.name,
          isEqualTo: selectedCity.documentId,
        )
        .orderBy(
          FirebaseQueryItems.createdAt.name,
          descending: state.sortingType == SortingTypes.newest,
        );
    return query;
  }

  void changeHomeViewCardType() {
    state = state.copyWith(isGridView: !state.isGridView);
    ref.read(productProviderState.notifier).saveLatestGridViewType(
          isSelected: state.isGridView,
        );
  }

  void changeSortingType(SortingTypes type) {
    state = state.copyWith(sortingType: type);
  }
}
