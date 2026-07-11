import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/mixin/rate_comment_list_view_mixin.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_comment_card.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class RateCommentListView extends ConsumerStatefulWidget {
  const RateCommentListView({
    required this.isCommentEnabled,
    required this.placeId,
    super.key,
  });
  final bool isCommentEnabled;
  final String placeId;

  @override
  ConsumerState<RateCommentListView> createState() =>
      _RateCommentListViewState();
}

final class _RateCommentListViewState extends ConsumerState<RateCommentListView>
    with AppProviderMixin<RateCommentListView>, RateCommentListViewMixin {
  @override
  Widget build(BuildContext context) {
    final hasVoted = ref.watch(
      rateCommunityViewModelProvider(
        widget.placeId,
      ).select((state) => state.hasVoted),
    );
    return Column(
      children: [
        if (widget.isCommentEnabled)
          _CommentListBody(
            placeId: widget.placeId,
          ),

        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: GeneralButtonV2.active(
            label: _buttonLabel(hasVoted),
            isBorderless: widget.isCommentEnabled,
            isEnabled: widget.isCommentEnabled && !hasVoted,
            action: () => onAddCommentPressed(hasVoted: hasVoted),
          ),
        ),
      ],
    );
  }

  String _buttonLabel(bool hasVoted) {
    if (!widget.isCommentEnabled) {
      return LocaleKeys.rate_commentingDisabled.tr();
    }
    if (hasVoted) return LocaleKeys.rate_commentAdded.tr();
    return LocaleKeys.rate_addComment.tr();
  }
}

final class _CommentListBody extends ConsumerWidget {
  const _CommentListBody({required this.placeId});
  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rateCommunityViewModelProvider(placeId));
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.comments.isEmpty) {
      return GeneralContentSubTitle(
        value: LocaleKeys.rate_noCommentsYet.tr(),
        textAlign: TextAlign.center,
      );
    }
    final notifier = ref.read(
      rateCommunityViewModelProvider(placeId).notifier,
    );
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.comments.length,
      itemBuilder: (context, index) {
        final rate = state.comments[index];
        final isOwn = state.vote?.userId == rate.userId;
        final canModify = isOwn && !state.isProcessing;
        return RateCommentCard(
          rateModel: rate,
          onEdit: canModify
              ? () => RateSheetFactory.showRateCard(
                  context,
                  placeId: placeId,
                  initialComment: rate.comment,
                )
              : null,
          onDelete: canModify ? notifier.deleteVote : null,
        );
      },
    );
  }
}
