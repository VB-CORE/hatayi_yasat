import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
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

part 'sub_view/discussion_entries_list.dart';
part 'sub_view/discussion_header_title.dart';

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
              color: context.appColors.navy400,
              icon: AppIcons.comment,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const PagePadding.vertical8Symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: WidgetSizes.spacingXs,
            children: [
              Padding(
                padding: const PagePadding.horizontal16Symmetric(),
                child: GeneralInfoBanner(
                  icon: AppIcons.visibilityOff,
                  message: LocaleKeys
                      .community_groupDetail_discussions_anonymityBanner
                      .tr(),
                ),
              ),
              Expanded(
                child: _EntriesList(
                  state: state,
                  scrollController: entriesScrollController,
                ),
              ),
              Padding(
                padding: const PagePadding.horizontal16Symmetric(),
                child: DiscussionReplyComposer(
                  controller: replyController,
                  onSubmit: submitReply,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
