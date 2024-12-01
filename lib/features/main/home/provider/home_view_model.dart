import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/home_state.dart';
import 'package:lifeclient/product/model/enum/firebase_query_items.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:lifeclient/product/utility/mixin/city_selection_mixin.dart';
import 'package:lifeclient/sub_feature/city/provider/city_state.dart';
import 'package:lifeclient/sub_feature/city/provider/city_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
final class HomeViewModel extends _$HomeViewModel
    with ProjectDependencyMixin, CitySelectionMixin {
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

  CityState get cityState => ref.watch(cityViewModelProvider);

  Query<StoreModel?> fetchApprovedApplications() {
    return firebaseService
        .collectionReference(
          CollectionPaths.approvedApplications,
          StoreModel.empty(),
        )
        .where(
          FirebaseQueryItems.cityId.name,
          isEqualTo: getCityIdByName(cityState.selectedCity),
        );
  }

  Query<StoreModel?> fetchApprovedCollectionQuery() {
    return firebaseService
        .queryWithOrderBy(
          path: CollectionPaths.approvedApplications,
          model: StoreModel.empty(),
          orderBy: MapEntry(
            FirebaseQueryItems.createdAt.name,
            state.sortingType == SortingTypes.newest,
          ),
        )
        .where(
          FirebaseQueryItems.cityId.name,
          isEqualTo: getCityIdByName(cityState.selectedCity),
        );
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
