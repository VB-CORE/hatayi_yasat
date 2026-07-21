import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';
import 'package:lifeclient/features/community/widget/group_member_avatar.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/image/hero_photo_view_page.dart';

@immutable
final class GroupPostCard extends StatelessWidget {
  const GroupPostCard({
    required this.model,
    required this.isLiked,
    required this.onLikeTap,
    required this.onCommentTap,
    super.key,
  });

  final GroupPostModel model;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;

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
            _PostAuthorRow(model: model),
            if (model.content.isNotEmpty) ...[
              const EmptyBox.smallHeight(),
              GeneralContentSubTitle(value: model.content),
            ],
            if (model.imageFile != null || model.imageUrl != null) ...[
              const EmptyBox.smallHeight(),
              _PostImage(model: model),
            ],
            const EmptyBox.smallHeight(),
            _PostFooterRow(
              model: model,
              isLiked: isLiked,
              onLikeTap: onLikeTap,
              onCommentTap: onCommentTap,
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
        imageFile: model.imageFile,
      ),
      borderRadius: CustomRadius.medium,
      child: Hero(
        tag: model.id,
        child: ClipRRect(
          borderRadius: CustomRadius.medium,
          child: SizedBox(
            height: context.sized.dynamicHeight(0.18),
            width: double.infinity,
            child: model.imageFile != null
                ? Image.file(model.imageFile!, fit: BoxFit.cover)
                : CustomNetworkImage(
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
  const _PostAuthorRow({required this.model});

  final GroupPostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GroupMemberAvatar(displayName: model.author.displayName),
        const EmptyBox(width: WidgetSizes.spacingS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentSubTitle(
              value: model.author.displayName,
              fontWeight: FontWeight.w700,
            ),
            GeneralContentSmallTitle(
              value: model.createdAt.timeAgo,
              color: context.appColors.navy300,
            ),
          ],
        ),
      ],
    );
  }
}

final class _PostFooterRow extends StatelessWidget {
  const _PostFooterRow({
    required this.model,
    required this.isLiked,
    required this.onLikeTap,
    required this.onCommentTap,
  });

  final GroupPostModel model;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;

  @override
  Widget build(BuildContext context) {
    final navy400 = context.appColors.navy400;
    return Row(
      children: [
        InkWell(
          onTap: onLikeTap,
          borderRadius: CustomRadius.small,
          child: Row(
            children: [
              Icon(
                isLiked ? AppIcons.favorite : AppIcons.favoriteBorder,
                size: AppIconSizes.xMedium,
                color: context.general.colorScheme.tertiary,
              ),
              const EmptyBox(width: WidgetSizes.spacingXxs),
              GeneralContentSmallTitle(
                value: model.likeCount.toString(),
                color: navy400,
              ),
            ],
          ),
        ),
        const EmptyBox.middleWidth(),
        InkWell(
          onTap: onCommentTap,
          borderRadius: CustomRadius.small,
          child: Row(
            children: [
              Icon(
                AppIcons.comment,
                size: AppIconSizes.xMedium,
                color: navy400,
              ),
              const EmptyBox(width: WidgetSizes.spacingXxs),
              GeneralContentSmallTitle(
                value: LocaleKeys.community_groupDetail_wall_commentCount.tr(
                  args: [model.commentCount.toString()],
                ),
                color: navy400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
