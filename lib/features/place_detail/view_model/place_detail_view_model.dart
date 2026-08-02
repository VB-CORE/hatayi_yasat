import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_args.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_state.dart';
import 'package:lifeclient/product/utility/extension/store_etension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_detail_view_model.g.dart';

@riverpod
final class PlaceDetailViewModel extends _$PlaceDetailViewModel
    with ProjectDependencyMixin {
  @override
  PlaceDetailState build(PlaceDetailArgs args) {
    unawaited(_incrementVisitCount(args.placeId));

    if (args.hasStore) return PlaceDetailState(storeModel: args.store);

    if (args.placeId.isEmpty) {
      return PlaceDetailState(storeModel: StoreModel.empty(), isError: true);
    }

    unawaited(_fetchStoreModel(args.placeId));

    return PlaceDetailState(storeModel: StoreModel.empty(), isFetching: true);
  }

  Future<void> _fetchStoreModel(String id) async {
    final result = await firestoreService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: id,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        storeModel: data ?? StoreModel.empty(),
        isFetching: false,
        isError: data == null,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }

  Future<void> _incrementVisitCount(String id) async {
    await firestoreService.updateFields(
      path: CollectionPaths.approvedApplications,
      documentId: id,
      fields: {StoreModelExtension.visitCountField: FieldValue.increment(1)},
    );
  }

  void applyRatingDelta({required int scoreDelta, required int countDelta}) {
    final store = state.storeModel;
    final nextCount = store.ratingCount + countDelta;
    if (nextCount < 0) return;
    state = state.copyWith(
      storeModel: store.copyWith(
        ratingSum: store.ratingSum + scoreDelta,
        ratingCount: nextCount,
      ),
    );
  }

  Future<void> retry() async {
    if (args.placeId.isEmpty) return;
    state = state.copyWith(isFetching: true, isError: false);
    await _fetchStoreModel(args.placeId);
  }
}
