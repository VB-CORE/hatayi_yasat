import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/post_like_view_model.dart';
import 'package:lifeclient/features/community/widget/community_delete_confirm_dialog.dart';
import 'package:lifeclient/features/community/widget/community_options_sheet.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/button/like_button.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/image/hero_photo_view_page.dart';

@immutable
final class GroupPostCard extends StatelessWidget {
  const GroupPostCard({
    required this.model,
    required this.groupId,
    required this.groupName,
    super.key,
  });

  final GroupPostModel model;
  final String groupId;

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostAuthorRow(model: model, groupId: groupId),
            if (model.content.isNotEmpty) ...[
              const EmptyBox.smallHeight(),
              GeneralContentSubTitle(value: model.content),
            ],
            if (model.imageUrl != null) ...[
              const EmptyBox.smallHeight(),
              _PostImage(model: model),
            ],
            const EmptyBox.smallHeight(),
            _PostFooterRow(
              model: model,
              groupId: groupId,
              groupName: groupName,
            ),
          ],
        ),
      ),
    );
  }
}

final class _PostImage extends StatelessWidget {
  const _PostImage({required this.model});

  final GroupPostModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => HeroPhotoViewPage.show(
        context,
        heroTag: model.id,
        imageUrl: model.imageUrl,
      ),
      borderRadius: CustomRadius.medium,
      child: Hero(
        tag: model.id,
        child: ClipRRect(
          borderRadius: CustomRadius.medium,
          child: SizedBox(
            height: context.sized.dynamicHeight(0.18),
            width: double.infinity,
            child: CustomNetworkImage(
              imageUrl: model.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

final class _PostAuthorRow extends StatelessWidget {
  const _PostAuthorRow({required this.model, required this.groupId});

  final GroupPostModel model;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomUserAvatar(
          userName: model.author.displayName,
          avatarType: model.author.avatarType,
        ),
        const EmptyBox(width: WidgetSizes.spacingS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralContentSubTitle(
                value: model.author.displayName,
                fontWeight: FontWeight.w700,
              ),
              GeneralContentSmallTitle(
                value: model.createdAt.timeAgoOrNow,
                color: context.appColors.navy300,
              ),
            ],
          ),
        ),
        _PostMoreButton(model: model, groupId: groupId),
      ],
    );
  }
}

final class _PostMoreButton extends ConsumerWidget {
  const _PostMoreButton({required this.model, required this.groupId});

  final GroupPostModel model;
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(
      groupMembersViewModelProvider(groupId).select((s) => s.currentMember),
    );
    final canDelete = currentMember != null &&
        (model.author.uid == currentMember.uid || currentMember.isAdmin);
    if (!canDelete) return const SizedBox.shrink();

    return IconButton(
      icon: Icon(AppIcons.moreDots, color: context.appColors.navy300),
      onPressed: () => _onMorePressed(context, ref),
    );
  }

  Future<void> _onMorePressed(BuildContext context, WidgetRef ref) async {
    final action = await showModalBottomSheet<CommunityOptionAction>(
      context: context,
      builder: (_) => const CommunityOptionsSheet(),
    );
    if (action != CommunityOptionAction.delete || !context.mounted) return;

    final isConfirmed = await CommunityDeleteConfirmDialog.show(context);
    if (!isConfirmed) return;

    await ref
        .read(groupWallViewModelProvider(groupId).notifier)
        .deletePost(model);
  }
}

final class _PostFooterRow extends StatelessWidget {
  const _PostFooterRow({
    required this.model,
    required this.groupId,
    required this.groupName,
  });

  final GroupPostModel model;
  final String groupId;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LikeButton(model: model, groupId: groupId, groupName: groupName),
        const EmptyBox(width: WidgetSizes.spacingXxs),
        GeneralContentSmallTitle(
          value: model.likeCount.toString(),
          color: context.appColors.navy400,
        ),
      ],
    );
  }
}

final class _LikeButton extends ConsumerWidget {
  const _LikeButton({
    required this.model,
    required this.groupId,
    required this.groupName,
  });

  final GroupPostModel model;
  final String groupId;
  final String groupName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = postLikeViewModelProvider(groupId, model.id);
    final isLiked = ref.watch(provider.select((state) => state.isLiked));

    return CustomAnimatedLikeButton(
      isLiked: isLiked,
      size: AppIconSizes.xMedium,
      likeBuilder: (isLiked) => Icon(
        isLiked ? AppIcons.favorite : AppIcons.favoriteBorder,
        size: AppIconSizes.xMedium,
        color: context.general.colorScheme.tertiary,
      ),
      onTap: (_) =>
          ref.read(provider.notifier).toggle(model),
    );
  }
}
