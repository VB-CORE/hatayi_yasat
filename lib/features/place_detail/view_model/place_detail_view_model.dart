import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_args.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_detail_view_model.g.dart';

@riverpod
final class PlaceDetailViewModel extends _$PlaceDetailViewModel
    with ProjectDependencyMixin {
  @override
  PlaceDetailState build(PlaceDetailArgs args) {
    if (args.hasStore) return PlaceDetailState(storeModel: args.store);

    if (args.placeId.isEmpty) {
      return PlaceDetailState(storeModel: StoreModel.empty(), isError: true);
    }

    unawaited(_fetchStoreModel(args.placeId));

    return PlaceDetailState(storeModel: StoreModel.empty(), isFetching: true);
  }

  Future<void> _fetchStoreModel(String id) async {
    final store = await firebaseService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: id,
    );

    state = state.copyWith(
      storeModel: store ?? StoreModel.empty(),
      isFetching: false,
      isError: store == null,
    );
  }
}
