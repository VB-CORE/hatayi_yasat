import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_panel_view_model.g.dart';

@riverpod
final class MerchantPanelViewModel extends _$MerchantPanelViewModel
    with ProjectDependencyMixin {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _pendingReplySubscription;

  @override
  MerchantPanelState build() {
    ref.onDispose(() {
      unawaited(_pendingReplySubscription?.cancel());
    });

    final storeId = _storeIdOf(_currentUser);
    if (storeId == null) {
      return const MerchantPanelState(isUnauthorized: true);
    }
    unawaited(_load(storeId: storeId));
    return const MerchantPanelState(isFetching: true);
  }

  UserModel? get _currentUser => ref.read(authViewModelProvider).user;

  String? get _currentUserId => authService.cachedUser?.uid;

  Future<void> refresh() async {
    final storeId = _storeIdOf(_currentUser);
    if (storeId == null) {
      state = const MerchantPanelState(isUnauthorized: true);
      return;
    }
    state = state.copyWith(
      isFetching: true,
      isError: false,
      isUnauthorized: false,
    );
    await _load(storeId: storeId);
  }

  String? _storeIdOf(UserModel? user) {
    final application = user?.application;
    if (application == null) return null;
    if (application.status != UserApplicationStatus.approved) return null;
    return application.id.isEmpty ? null : application.id;
  }

  Future<void> _load({required String storeId}) async {
    final currentUserId = _currentUserId;
    if (currentUserId == null) {
      state = state.copyWith(isFetching: false, isUnauthorized: true);
      return;
    }

    final result = await firestoreService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: storeId,
    );

    switch (result) {
      case FirebaseFailure():
        state = state.copyWith(isFetching: false, isError: true);
      case FirebaseSuccess(:final data):
        if (data == null || data.ownerId != currentUserId) {
          state = state.copyWith(isFetching: false, isUnauthorized: true);
          return;
        }
        state = state.copyWith(store: data, isFetching: false, isError: false);
        _watchPendingReplyBadge(storeId);
    }
  }

  void _watchPendingReplyBadge(String storeId) {
    unawaited(_pendingReplySubscription?.cancel());
    _pendingReplySubscription = CollectionPaths.approvedApplications
        .sub(storeId, SubCollectionPaths.votes)
        .collection
        .where(RateModel.merchantReplyField, isNull: true)
        .limit(1)
        .snapshots()
        .listen(
          (snapshot) {
            state = state.copyWith(
              hasPendingReply: snapshot.docs.isNotEmpty,
            );
          },
          onError: (_) {
            state = state.copyWith(hasPendingReply: false);
          },
        );
  }
}
