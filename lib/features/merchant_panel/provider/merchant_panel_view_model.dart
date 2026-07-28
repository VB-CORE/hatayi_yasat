import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_state.dart';
import 'package:lifeclient/product/model/auth/user/user_application_status.dart';
import 'package:lifeclient/product/model/auth/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_panel_view_model.g.dart';

@riverpod
final class MerchantPanelViewModel extends _$MerchantPanelViewModel
    with ProjectDependencyMixin {
  @override
  MerchantPanelState build() {
    final user = ref.watch(authViewModelProvider).user;
    final storeId = _storeIdOf(user);
    if (storeId == null) {
      return const MerchantPanelState(isUnauthorized: true);
    }
    unawaited(_load(storeId: storeId, ownerUid: user!.uid));
    return const MerchantPanelState(isFetching: true);
  }

  Future<void> refresh() async {
    final user = ref.read(authViewModelProvider).user;
    final storeId = _storeIdOf(user);
    if (storeId == null) {
      state = const MerchantPanelState(isUnauthorized: true);
      return;
    }
    state = state.copyWith(
      isFetching: true,
      isError: false,
      isUnauthorized: false,
    );
    await _load(storeId: storeId, ownerUid: user!.uid);
  }

  String? _storeIdOf(UserModel? user) {
    final application = user?.application;
    if (application == null) return null;
    if (application.status != UserApplicationStatus.approved) return null;
    return application.id.isEmpty ? null : application.id;
  }

  Future<void> _load({
    required String storeId,
    required String ownerUid,
  }) async {
    final result = await firestoreService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: storeId,
    );

    switch (result) {
      case FirebaseFailure():
        state = state.copyWith(isFetching: false, isError: true);
      case FirebaseSuccess(:final data):
        if (data == null || data.ownerId != ownerUid) {
          state = state.copyWith(isFetching: false, isUnauthorized: true);
          return;
        }
        state = state.copyWith(store: data, isFetching: false, isError: false);
        await _loadReviews(storeId);
    }
  }

  Future<void> _loadReviews(String storeId) async {
    final result = await firestoreService.getList<RateModel>(
      model: const RateModel(),
      path: CollectionPaths.approvedApplications.sub(
        storeId,
        SubCollectionPaths.votes,
      ),
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(reviews: data),
      FirebaseFailure() => state.copyWith(isError: true),
    };
  }
}
