import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/mixin/group_discussions_view_mixin.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/discussions_composer.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/group_discussion_tile.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

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
    final model = widget.model;
    return CustomFirestoreListView<GroupDiscussionModel>(
      query: ref
          .read(groupDiscussionsViewModelProvider(model.id).notifier)
          .discussions,
      padding: const PagePadding.horizontal16Symmetric(),
      separator: const EmptyBox.smallHeight(),
      header: DiscussionsComposer(groupId: model.id, onStarted: openDiscussion),
      onEmpty: FirestoreListEmpty(
        title: LocaleKeys.community_groupDetail_discussions_empty.tr(),
      ),
      itemBuilder: (context, discussion) => GroupDiscussionTile(
        model: discussion,
        groupId: model.id,
        onTap: () => DiscussionDetailRoute(
          $extra: DiscussionDetailArgs(group: model, discussion: discussion),
        ).push<void>(context),
      ),
    );
  }
}
