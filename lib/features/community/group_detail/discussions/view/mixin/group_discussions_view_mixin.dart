import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_sheet.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDiscussionsViewMixin
    on
        ConsumerState<GroupDiscussionsView>,
        AppProviderMixin<GroupDiscussionsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(groupDiscussionsViewModelProvider.notifier)
            .fetchDiscussions(widget.model.id),
      );
    });
  }

  bool get isCurrentUserAdmin {
    final currentUserId = ref.watch(
      currentGroupMemberProvider.select((member) => member.id),
    );
    return widget.model.isAdmin(currentUserId);
  }

  Future<void> startDiscussion(BuildContext context) async {
    await StartDiscussionSheet.show(context);
    // TODO(community): Tartışma Detay PR'ında açılan tartışma
    // DiscussionDetailRoute'a yönlendirilecek.
  }
}
