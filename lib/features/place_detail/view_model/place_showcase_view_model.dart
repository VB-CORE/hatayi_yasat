import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/place_detail/view_model/place_showcase_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_showcase_view_model.g.dart';

@riverpod
final class PlaceShowcaseViewModel extends _$PlaceShowcaseViewModel
    with ProjectDependencyMixin {
  FirestoreCollectionPath get _showcase => CollectionPaths.approvedApplications
      .sub(placeId, SubCollectionPaths.showcase);

  @override
  PlaceShowcaseState build(String placeId) {
    if (placeId.isEmpty) return const PlaceShowcaseState();
    unawaited(_fetch());
    return const PlaceShowcaseState(isFetching: true);
  }

  Future<void> retry() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _fetch();
  }

  Future<void> _fetch() async {
    final result = await firestoreService.getList<MerchantShowcaseModuleModel>(
      model: const MerchantShowcaseModuleModel(),
      path: _showcase,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        modules:
            data
                .where((module) => !module.isDeleted && module.isPublished)
                .toList()
              ..sort((a, b) => a.order.compareTo(b.order)),
        isFetching: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
