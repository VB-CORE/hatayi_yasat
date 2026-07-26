import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDiscussionsViewMixin
    on
        ConsumerState<GroupDiscussionsView>,
        AppProviderMixin<GroupDiscussionsView> {
  void openDiscussion(GroupDiscussionModel discussion) {
    unawaited(
      DiscussionDetailRoute(
        $extra: DiscussionDetailArgs(
          group: widget.model,
          discussion: discussion,
        ),
      ).push<void>(context),
    );
  }
}
