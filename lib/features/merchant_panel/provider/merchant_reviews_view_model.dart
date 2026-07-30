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
  FirestoreCollectionPath get _votes => CollectionPaths.approvedApplications
      .sub(storeId, SubCollectionPaths.votes);

  @override
  MerchantReviewsState build(String storeId) => const MerchantReviewsState();

  void changeFilter(MerchantReviewFilter filter) {
    if (state.filter == filter) return;
    state = state.copyWith(filter: filter);
  }

  Future<bool> reply({
    required RateModel review,
    required String message,
  }) async {
    final text = message.trim();
    if (text.isEmpty || state.isSubmitting) return false;

    state = state.copyWith(replyingVoterUid: review.voterUid);
    final result = await firestoreService.updateFields(
      path: _votes,
      documentId: review.voterUid,
      fields: RateModel.updateFields(merchantReply: text),
    );

    state = state.copyWith(
      clearReplyingVoterUid: true,
      isError: !result.isSuccess,
    );
    if (result.isSuccess) {
      await ref.read(merchantPanelViewModelProvider.notifier).refresh();
    }
    return result.isSuccess;
  }

  Future<bool> removeReply(RateModel review) async {
    if (!review.hasMerchantReply || state.isSubmitting) return false;

    state = state.copyWith(replyingVoterUid: review.voterUid);
    final result = await firestoreService.updateFields(
      path: _votes,
      documentId: review.voterUid,
      fields: RateModel.updateFields(clearMerchantReply: true),
    );

    state = state.copyWith(
      clearReplyingVoterUid: true,
      isError: !result.isSuccess,
    );
    if (result.isSuccess) {
      await ref.read(merchantPanelViewModelProvider.notifier).refresh();
    }
    return result.isSuccess;
  }
}
