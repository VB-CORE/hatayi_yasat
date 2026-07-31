import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/sub_feature/developers/provider/developers_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'developers_view_model.g.dart';

@riverpod
final class DevelopersViewModel extends _$DevelopersViewModel
    with ProjectDependencyMixin {
  @override
  DevelopersState build() {
    unawaited(_loadDevelopers());
    return const DevelopersState(isFetching: true);
  }

  Future<void> fetchDevelopers() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _loadDevelopers();
  }

  Future<void> _loadDevelopers() async {
    try {
      final collection = firestoreService.collectionReference<DeveloperModel>(
        CollectionPaths.developers,
        DeveloperModel(),
      );

      final results = await Future.wait([
        collection.where('active', isEqualTo: true).get(),
        collection.where('active', isEqualTo: false).get(),
      ]);

      state = state.copyWith(
        activeDevelopers: _mapDocs(results[0]),
        veteranDevelopers: _mapDocs(results[1]),
        isFetching: false,
        isError: false,
      );
    } on Object {
      state = state.copyWith(isFetching: false, isError: true);
    }
  }

  List<DeveloperModel> _mapDocs(QuerySnapshot<DeveloperModel?> snapshot) {
    return snapshot.docs
        .map((doc) => doc.data())
        .whereType<DeveloperModel>()
        .toList();
  }
}
