import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/mixin/group_discussions_view_mixin.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/group_discussion_tile.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_card.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

final class GroupDiscussionsView extends ConsumerStatefulWidget {
  const GroupDiscussionsView({required this.model, super.key});

  final GroupModel model;

  @override
  ConsumerState<GroupDiscussionsView> createState() =>
      _GroupDiscussionsViewState();
}

final class _GroupDiscussionsViewState
    extends ConsumerState<GroupDiscussionsView>
    with
        AppProviderMixin<GroupDiscussionsView>,
        GroupDiscussionsViewMixin,
        AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(groupDiscussionsViewModelProvider);
    return switch (state) {
      GroupDiscussionsState(isFetching: true) => const SizedBox.shrink(),
      GroupDiscussionsState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
          onRefresh: () {
            unawaited(
              ref
                  .read(groupDiscussionsViewModelProvider.notifier)
                  .fetchDiscussions(widget.model.id),
            );
          },
        ),
      ),
      GroupDiscussionsState(:final discussions) => ListView(
        padding: const PagePadding.horizontal16Symmetric(),
        children: [
          const EmptyBox.middleHeight(),
          if (widget.model.isCurrentUserAdmin) ...[
            StartDiscussionCard(onTap: () => startDiscussion(context)),
            const EmptyBox.middleHeight(),
          ],
          if (discussions.isEmpty)
            GeneralNotFoundWidget(
              title: LocaleKeys.community_groupDetail_discussions_empty.tr(),
            )
          else
            ...discussions.map(
              (discussion) => Padding(
                padding: const PagePadding.vertical6Symmetric(),
                child: GroupDiscussionTile(
                  model: discussion,
                  onTap: () => DiscussionDetailRoute(
                    $extra: DiscussionDetailArgs(
                      group: widget.model,
                      discussion: discussion,
                    ),
                  ).push<void>(context),
                ),
              ),
            ),
          const EmptyBox.middleHeight(),
        ],
      ),
    };
  }
}
