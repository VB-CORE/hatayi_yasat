part of '../group_detail_sliver_header.dart';

final class _ExpandedBackground extends StatelessWidget {
  const _ExpandedBackground({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      background: Stack(
        fit: StackFit.expand,
        children: [
          GroupCoverImage(groupId: model.id, imageUrl: model.coverImageUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  context.appColors.navy900.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),
          Positioned(
            left: WidgetSizes.spacingM,
            right: WidgetSizes.spacingM,
            bottom: kTextTabBarHeight + WidgetSizes.spacingS,
            child: _GroupTitleArea(model: model),
          ),
        ],
      ),
    );
  }
}

final class _GroupTitleArea extends StatelessWidget {
  const _GroupTitleArea({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    final typeLabel = model.type == GroupType.open
        ? LocaleKeys.community_groupDetail_openGroup.tr()
        : LocaleKeys.community_groupDetail_closedGroup.tr();
    final onCover = context.general.colorScheme.onTertiary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentTitle(
          value: model.name,
          color: onCover,
          fontWeight: FontWeight.w700,
          maxLine: AppConstants.kOne,
        ),
        const EmptyBox.xSmallHeight(),
        Row(
          children: [
            Icon(
              model.type == GroupType.open
                  ? AppIcons.globe
                  : AppIcons.lockPerson,
              size: AppIconSizes.xMedium,
              color: onCover,
            ),
            const EmptyBox(width: WidgetSizes.spacingXxs),
            GeneralContentSmallTitle(value: typeLabel, color: onCover),
            const EmptyBox.smallWidth(),
            Icon(
              AppIcons.group,
              size: AppIconSizes.xMedium,
              color: onCover,
            ),
            const EmptyBox(width: WidgetSizes.spacingXxs),
            GeneralContentSmallTitle(
              value: LocaleKeys.community_groupDetail_memberCount.tr(
                args: [model.memberCount.toString()],
              ),
              color: onCover,
            ),
          ],
        ),
      ],
    );
  }
}
