import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/home/provider/home_state.dart';

part 'home_view_model.g.dart';

@riverpod
final class HomeViewModel extends _$HomeViewModel with ProjectDependencyMixin {
  @override
  HomeState build() {
    final categories = ref.read(productProviderState).categoryItems;
    return HomeState(
      categories: categories,
    );
  }

  CollectionReference<StoreModel?> fetchJobsCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.approvedApplications,
      StoreModel.empty(),
    );
  }
}
