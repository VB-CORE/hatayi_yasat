import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/developers/provider/developers_state.dart';

part 'developers_view_model.g.dart';

@riverpod
final class DevelopersViewModel extends _$DevelopersViewModel
    with ProjectDependencyMixin {
  @override
  DevelopersState build() {
    return const DevelopersState();
  }

  CollectionReference<DeveloperModel?> fetchDevelopersCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.developers,
      DeveloperModel(),
    );
  }
}
