import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/mixin/rate_comment_list_view_mixin.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_comment_options_sheet.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_delete_confirm_dialog.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_circle_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_circle_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';

part 'widget/rate_comment_card.dart';

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
    final state = ref.watch(rateCommunityViewModelProvider(widget.placeId));
    final hasVoted = state.hasVoted;
    return SliverMainAxisGroup(
      slivers: [
        if (widget.isCommentEnabled) _CommentListBody(placeId: widget.placeId),
        if (widget.isCommentEnabled && state.isError)
          SliverToBoxAdapter(
            child: _RateLoadErrorRetry(
              onRetry: ref
                  .read(
                    rateCommunityViewModelProvider(widget.placeId).notifier,
                  )
                  .retry,
            ),
          )
        else if (widget.isCommentEnabled && !state.isLoading && !hasVoted)
          SliverToBoxAdapter(
            child: Padding(
              padding: const PagePadding.vertical12Symmetric(),
              child: GeneralButtonV2.active(
                label: _buttonLabel(
                  hasVoted: hasVoted,
                  isSignInRequired: state.isSignInRequired,
                ),
                isBorderless: widget.isCommentEnabled,
                action: () => onAddCommentPressed(hasVoted: hasVoted),
              ),
            ),
          ),
      ],
    );
  }

  String _buttonLabel({
    required bool hasVoted,
    required bool isSignInRequired,
  }) {
    if (!widget.isCommentEnabled) {
      return LocaleKeys.rate_commentingDisabled.tr();
    }
    if (isSignInRequired) return LocaleKeys.button_login.tr();
    if (hasVoted) return LocaleKeys.rate_commentAdded.tr();
    return LocaleKeys.rate_addComment.tr();
  }
}

const int _previewCommentCount = 5;

final class _CommentListBody extends ConsumerWidget {
  const _CommentListBody({required this.placeId});
  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rateCommunityViewModelProvider(placeId));
    final notifier = ref.read(
      rateCommunityViewModelProvider(placeId).notifier,
    );
    if (state.isSignInRequired) {
      return SliverToBoxAdapter(
        child: GeneralContentSubTitle(
          value: LocaleKeys.rate_signInToSeeComments.tr(),
          textAlign: TextAlign.center,
        ),
      );
    }
    return StreamBuilder<List<RateModel>>(
      key: ValueKey(state.retryToken),
      stream: notifier.votesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (state.isError) return const SliverToBoxAdapter(child: SizedBox());
          return SliverToBoxAdapter(
            child: _RateLoadErrorRetry(onRetry: notifier.retry),
          );
        }
        final comments = snapshot.data;
        if (comments == null) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: PagePadding.vertical12Symmetric(),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        }
        if (comments.isEmpty) {
          return SliverToBoxAdapter(
            child: GeneralContentSubTitle(
              value: LocaleKeys.rate_noCommentsYet.tr(),
              textAlign: TextAlign.center,
            ),
          );
        }
        final hasHiddenComments =
            !state.showAllComments && comments.length > _previewCommentCount;
        final visibleCount = hasHiddenComments
            ? _previewCommentCount
            : comments.length;

        return SliverMainAxisGroup(
          slivers: [
            DecoratedSliver(
              decoration: BoxDecoration(
                color: context.appColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              sliver: SliverList.builder(
                itemCount: visibleCount,
                itemBuilder: (context, index) {
                  final isLastItem = index + 1 == visibleCount;
                  final rate = comments[index];
                  final isOwn = state.vote?.voterUid == rate.voterUid;

                  final canModify = isOwn && !state.isProcessing;
                  return Column(
                    children: [
                      _RateCommentCard(
                        rateModel: rate,
                        onEdit: canModify
                            ? () => RateSheetFactory.showRateCard(
                                context,
                                placeId: placeId,
                                initialComment: rate.comment,
                              )
                            : null,
                        onDelete: canModify
                            ? () => _onDeletePressed(context, notifier)
                            : null,
                      ),
                      if (!isLastItem)
                        const Divider(indent: AppSpacing.md, height: 1),
                    ],
                  );
                },
              ),
            ),
            if (hasHiddenComments)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const PagePadding.vertical12Symmetric(),
                  child: GeneralButtonV2.active(
                    label: LocaleKeys.button_more.tr(),
                    isBorderless: true,
                    action: notifier.expandComments,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _onDeletePressed(
    BuildContext context,
    RateCommunityViewModel notifier,
  ) async {
    final isConfirmed = await RateDeleteConfirmDialog.show(context);
    if (!isConfirmed) return;
    await notifier.deleteVote();
  }
}

final class _RateLoadErrorRetry extends StatelessWidget {
  const _RateLoadErrorRetry({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralContentSubTitle(
          value: LocaleKeys.rate_commentsLoadFailed.tr(),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: GeneralButtonV2.active(
            label: LocaleKeys.button_tryAgain.tr(),
            isBorderless: true,
            action: onRetry,
          ),
        ),
      ],
    );
  }
}
