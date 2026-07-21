import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/mixin/group_wall_view_mixin.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/group_post_card.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/group_post_composer.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

final class GroupWallView extends ConsumerStatefulWidget {
  const GroupWallView({required this.model, super.key});

  final GroupModel model;

  @override
  ConsumerState<GroupWallView> createState() => _GroupWallViewState();
}

final class _GroupWallViewState extends ConsumerState<GroupWallView>
    with
        AppProviderMixin<GroupWallView>,
        GroupWallViewMixin,
        AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(groupWallViewModelProvider);
    return switch (state) {
      GroupWallState(isFetching: true) => const SizedBox.shrink(),
      GroupWallState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
          onRefresh: () {
            unawaited(
              ref
                  .read(groupWallViewModelProvider.notifier)
                  .fetchPosts(widget.model.id),
            );
          },
        ),
      ),
      GroupWallState(:final posts) => ListView(
        padding: const PagePadding.horizontal16Symmetric(),
        children: [
          const EmptyBox.middleHeight(),
          GroupPostComposer(
            controller: postController,
            imageFile: postImageFile,
            onPickImage: pickPostImage,
            onRemoveImage: removePostImage,
            onSubmit: submitPost,
          ),
          if (posts.isEmpty)
            GeneralNotFoundWidget(
              title: LocaleKeys.community_groupDetail_wall_empty.tr(),
            )
          else
            ...posts.map(
              (post) => Padding(
                padding: const PagePadding.vertical6Symmetric(),
                child: GroupPostCard(
                  model: post,
                  onLikeTap: () => ref
                      .read(groupWallViewModelProvider.notifier)
                      .toggleLike(post.id),
                  // TODO(community): Yorumlar ekranı tasarımı gelince
                  // bağlanacak.
                  onCommentTap: () {},
                ),
              ),
            ),
          const EmptyBox.middleHeight(),
        ],
      ),
    };
  }
}
