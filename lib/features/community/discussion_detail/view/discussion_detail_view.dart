import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_view_model.dart';
import 'package:lifeclient/features/community/discussion_detail/view/mixin/discussion_detail_view_mixin.dart';
import 'package:lifeclient/features/community/discussion_detail/view/widget/discussion_entry_tile.dart';
import 'package:lifeclient/features/community/discussion_detail/view/widget/discussion_reply_composer.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class DiscussionDetailView extends ConsumerStatefulWidget {
  const DiscussionDetailView({required this.args, super.key});

  final DiscussionDetailArgs args;

  @override
  ConsumerState<DiscussionDetailView> createState() =>
      _DiscussionDetailViewState();
}

final class _DiscussionDetailViewState
    extends ConsumerState<DiscussionDetailView>
    with AppProviderMixin<DiscussionDetailView>, DiscussionDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discussionDetailViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: WidgetSizes.spacingXxl9,
        title: _DiscussionHeaderTitle(args: widget.args),
        actions: [
          Padding(
            padding: const PagePadding.onlyRight(),
            child: GeneralStatusBadge(
              label: state.entries.length.toString(),
              color: AppColors.navy400,
              icon: AppIcons.comment,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EmptyBox.smallHeight(),
            Padding(
              padding: const PagePadding.horizontal16Symmetric(),
              child: GeneralInfoBanner(
                icon: AppIcons.visibilityOff,
                message: LocaleKeys
                    .community_groupDetail_discussions_anonymityBanner
                    .tr(),
              ),
            ),
            const EmptyBox.smallHeight(),
            Expanded(
              child: _EntriesList(
                state: state,
                scrollController: entriesScrollController,
              ),
            ),
            const EmptyBox.smallHeight(),
            Padding(
              padding: const PagePadding.horizontal16Symmetric(),
              child: DiscussionReplyComposer(
                controller: replyController,
                onSubmit: submitReply,
              ),
            ),
            const EmptyBox.smallHeight(),
          ],
        ),
      ),
    );
  }
}

final class _DiscussionHeaderTitle extends StatelessWidget {
  const _DiscussionHeaderTitle({required this.args});

  final DiscussionDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentTitle(
          value: args.discussion.title,
          fontWeight: FontWeight.w700,
          maxLine: AppConstants.kTwo,
        ),
        GeneralContentSmallTitle(
          value: LocaleKeys.community_groupDetail_discussions_openedByGroup.tr(
            namedArgs: {
              'name': args.discussion.author.maskedDisplayName,
              'group': args.group.name,
            },
          ),
          color: AppColors.navy300,
          maxLine: AppConstants.kOne,
        ),
      ],
    );
  }
}

final class _EntriesList extends StatelessWidget {
  const _EntriesList({required this.state, required this.scrollController});

  final DiscussionDetailState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      DiscussionDetailState(isFetching: true) => const SizedBox.shrink(),
      DiscussionDetailState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
        ),
      ),
      DiscussionDetailState(:final entries) => ListView.separated(
        controller: scrollController,
        padding: const PagePadding.horizontal16Symmetric(),
        itemCount: entries.length,
        separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
        itemBuilder: (context, index) =>
            DiscussionEntryTile(model: entries[index]),
      ),
    };
  }
}
