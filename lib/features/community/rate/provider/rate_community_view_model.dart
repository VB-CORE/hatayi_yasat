import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_view_model.g.dart';

@riverpod
final class RateCommunityViewModel extends _$RateCommunityViewModel
    with ProjectDependencyMixin {
  UserModel? get _currentUser {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user : null;
  }

  CollectionReference<Map<String, dynamic>> get _votes => CollectionPaths
      .approvedApplications
      .collection
      .doc(placeId)
      .collection(_votesPath);

  @override
  RateCommunityState build(String placeId) {
    final currentUid = _currentUser?.uid;
    if (currentUid == null) {
      return const RateCommunityState(isSignInRequired: true);
    }
    unawaited(_loadMyVote(currentUid));
    return const RateCommunityState(isLoading: true);
  }

  Query<RateModel?> votesQuery() => _votes
      .orderBy(_createdAtField, descending: true)
      .withConverter<RateModel?>(
        fromFirestore: _rateFromFirestore,
        toFirestore: _rateToFirestore,
      );

  void retry() {
    final currentUid = _currentUser?.uid;
    state = state.copyWith(
      retryToken: state.retryToken + 1,
      isError: false,
      isLoading: currentUid != null,
    );
    if (currentUid == null) return;
    unawaited(_loadMyVote(currentUid));
  }

  Future<void> _loadMyVote(String currentUid) async {
    final snapshot = await _guard(
      'fetchMyRate($currentUid)',
      _votes.doc(currentUid).get(),
    );
    if (snapshot == null) {
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }
    if (!snapshot.exists) {
      state = state.copyWith(clearVote: true, isLoading: false, isError: false);
      return;
    }

    final RateModel myVote;
    try {
      myVote = const RateModel().fromFirebase(snapshot);
    } on Object catch (error) {
      ProductLogger.log('fetchMyRate($currentUid) parse $error');
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }

    state = state.copyWith(vote: myVote, isLoading: false, isError: false);
  }

  void selectRating(double value) => state = state.copyWith(
    draftScore: value.round(),
    status: const RateActionIdle(),
  );

  void resetStatus() => state = state.copyWith(status: const RateActionIdle());

  Future<void> submit({String? comment}) async {
    final user = _currentUser;
    if (user == null || state.hasVoted || state.isProcessing || state.isError) {
      return;
    }
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.create),
    );
    final now = DateTime.now();
    final vote = RateModel(
      placeId: placeId,
      voterUid: user.uid,
      score: state.draftScore,
      createdAt: now,
      comment: comment?.trim(),
      userName: user.displayName,
      photoUrl: user.photoUrl,
      updatedAt: now,
    );
    final response = await _guard(
      'rate(${vote.voterUid})',
      _votes.doc(vote.voterUid).set(vote.toJson()).then((_) => true),
    );
    final success = response ?? false;
    if (success) {
      state = state.copyWith(
        vote: vote,
        status: const RateActionSucceeded(RateAction.create),
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.create));
    }
  }

  Future<void> changeComment({String? newComment}) async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.update),
    );
    final updated = currentVote.copyWith(
      comment: newComment?.trim(),
      updatedAt: DateTime.now(),
    );

    final response = await _guard(
      'changeComment(${updated.voterUid})',
      _votes
          .doc(updated.voterUid)
          .update({
            _commentField: updated.comment,
            _updatedAtField: FirebaseTimeParse.dateTimeToTimestamp(
              updated.updatedAt,
            ),
          })
          .then((_) => true),
    );
    final success = response ?? false;
    if (success) {
      state = state.copyWith(
        status: const RateActionSucceeded(RateAction.update),
        vote: updated,
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.update));
    }
  }

  Future<void> deleteVote() async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.delete),
    );
    final response = await _guard(
      'deleteRate(${currentVote.voterUid})',
      _votes.doc(currentVote.voterUid).delete().then((_) => true),
    );
    final success = response ?? false;
    if (success) {
      state = state.copyWith(
        clearVote: true,
        status: const RateActionSucceeded(RateAction.delete),
        draftScore: 0,
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.delete));
    }
  }

  Future<T?> _guard<T>(String label, Future<T> request) async {
    try {
      return await request.timeout(firebaseService.timeoutDuration);
    } on FirebaseException catch (error) {
      ProductLogger.log('$label ${error.code} ${error.message}');
      return null;
    } on TimeoutException catch (error) {
      ProductLogger.log('$label $error');
      return null;
    }
  }

  static RateModel? _rateFromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    try {
      return const RateModel().fromFirebase(snapshot);
    } on Object catch (error) {
      ProductLogger.log('votesQuery(${snapshot.id}) parse $error');
      return null;
    }
  }

  static Map<String, Object?> _rateToFirestore(
    RateModel? value,
    SetOptions? options,
  ) => throw UnimplementedError();

  static const String _votesPath = 'votes';
  static const String _createdAtField = 'createdAt';
  static const String _commentField = 'comment';
  static const String _updatedAtField = 'updatedAt';
}
