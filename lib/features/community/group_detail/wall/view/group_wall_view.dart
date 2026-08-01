import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/group_post_card.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/wall_composer.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

final class GroupWallView extends ConsumerStatefulWidget {
  const GroupWallView({required this.model, super.key});

  final GroupModel model;

  @override
  ConsumerState<GroupWallView> createState() => _GroupWallViewState();
}

final class _GroupWallViewState extends ConsumerState<GroupWallView>
    with AppProviderMixin<GroupWallView>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final model = widget.model;
    return CustomFirestoreListView<GroupPostModel>(
      query: ref.read(groupWallViewModelProvider(model.id).notifier).posts,
      padding: const PagePadding.horizontal16Symmetric(),
      separator: const EmptyBox.smallHeight(),
      header: WallComposer(groupId: model.id),
      onEmpty: FirestoreListEmpty(
        title: LocaleKeys.community_groupDetail_wall_empty.tr(),
      ),
      itemBuilder: (context, post) =>
          GroupPostCard(model: post, groupId: model.id, groupName: model.name),
    );
  }
}
