import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_view_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_reviews_view_model.g.dart';

@riverpod
final class MerchantReviewsViewModel extends _$MerchantReviewsViewModel
    with ProjectDependencyMixin {
  static const String _replyField = 'merchantReply';
  static const String _replyAtField = 'merchantReplyAt';

  FirestoreCollectionPath get _votes => CollectionPaths.approvedApplications
      .sub(storeId, SubCollectionPaths.votes);

  @override
  MerchantReviewsState build(String storeId) {
    unawaited(_fetch());
    return const MerchantReviewsState(isFetching: true);
  }

  void changeFilter(MerchantReviewFilter filter) {
    if (state.filter == filter) return;
    state = state.copyWith(filter: filter);
  }

  Future<void> retry() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _fetch();
  }

  Future<bool> reply({
    required RateModel review,
    required String message,
  }) async {
    final text = message.trim();
    if (text.isEmpty || state.isSubmitting) return false;

    state = state.copyWith(replyingVoterUid: review.voterUid);
    final now = DateTime.now();
    final result = await firestoreService.updateFields(
      path: _votes,
      documentId: review.voterUid,
      fields: {
        _replyField: text,
        _replyAtField: FirebaseTimeParse.dateTimeToTimestamp(now),
      },
    );

    if (!result.isSuccess) {
      state = state.copyWith(clearReplyingVoterUid: true, isError: true);
      return false;
    }

    final updated = review.copyWith(merchantReply: text, merchantReplyAt: now);
    state = state.copyWith(
      reviews: [
        for (final item in state.reviews)
          if (item.voterUid == review.voterUid) updated else item,
      ],
      clearReplyingVoterUid: true,
    );
    await ref.read(merchantPanelViewModelProvider.notifier).refresh();
    return true;
  }

  Future<bool> removeReply(RateModel review) async {
    if (!review.hasMerchantReply || state.isSubmitting) return false;

    state = state.copyWith(replyingVoterUid: review.voterUid);
    final result = await firestoreService.updateFields(
      path: _votes,
      documentId: review.voterUid,
      fields: {_replyField: null, _replyAtField: null},
    );

    if (!result.isSuccess) {
      state = state.copyWith(clearReplyingVoterUid: true, isError: true);
      return false;
    }

    final updated = review.copyWith(clearMerchantReply: true);
    state = state.copyWith(
      reviews: [
        for (final item in state.reviews)
          if (item.voterUid == review.voterUid) updated else item,
      ],
      clearReplyingVoterUid: true,
    );
    await ref.read(merchantPanelViewModelProvider.notifier).refresh();
    return true;
  }

  Future<void> _fetch() async {
    final result = await firestoreService.getList<RateModel>(
      model: const RateModel(),
      path: _votes,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        reviews: _sortedByDate(data),
        isFetching: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }

  List<RateModel> _sortedByDate(List<RateModel> reviews) {
    final sorted = [...reviews]
      ..sort((first, second) {
        final firstDate = first.createdAt;
        final secondDate = second.createdAt;
        if (firstDate == null || secondDate == null) return 0;
        return secondDate.compareTo(firstDate);
      });
    return sorted;
  }
}
