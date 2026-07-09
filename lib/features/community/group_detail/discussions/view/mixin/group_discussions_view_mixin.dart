import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_sheet.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDiscussionsViewMixin
    on
        ConsumerState<GroupDiscussionsView>,
        AppProviderMixin<GroupDiscussionsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(groupDiscussionsViewModelProvider.notifier)
          .fetchDiscussions(widget.model.id);
    });
  }

  Future<void> startDiscussion(BuildContext context) async {
    final discussion = await StartDiscussionSheet.show(context);
    if (discussion == null || !context.mounted) return;
    await DiscussionDetailRoute(
      $extra: DiscussionDetailArgs(group: widget.model, discussion: discussion),
    ).push<void>(context);
  }
}
