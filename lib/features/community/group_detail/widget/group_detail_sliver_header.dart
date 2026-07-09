import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';
import 'package:lifeclient/features/community/widget/group_cover_image.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupDetailSliverHeader extends StatelessWidget {
  const GroupDetailSliverHeader({required this.model, super.key});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL14,
      pinned: true,
      backgroundColor: AppColors.surface,
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.paddingOf(context).top;
          final collapsedHeight =
              topPadding + kToolbarHeight + kTextTabBarHeight;
          final maxExtent = WidgetSizes.spacingXxlL14 + topPadding;
          final expandRatio = maxExtent <= collapsedHeight
              ? 0.0
              : ((constraints.maxHeight - collapsedHeight) /
                        (maxExtent - collapsedHeight))
                    .clamp(0.0, 1.0);
          return Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: expandRatio,
                child: _ExpandedBackground(model: model),
              ),
              Positioned(
                top: topPadding,
                left: kZero,
                right: kZero,
                height: kToolbarHeight,
                child: _HeaderToolbar(
                  model: model,
                  titleOpacity: 1 - expandRatio,
                ),
              ),
            ],
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: ColoredBox(
          color: AppColors.surface,
          child: TabBar(
            labelColor: AppColors.coral,
            unselectedLabelColor: AppColors.navy300,
            indicatorColor: AppColors.coral,
            labelStyle: context.general.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              _HeaderTab(
                icon: AppIcons.gridView,
                label: LocaleKeys.community_groupDetail_tabWall.tr(),
              ),
              _HeaderTab(
                icon: AppIcons.forum,
                label: LocaleKeys.community_groupDetail_tabDiscussions.tr(),
              ),
              _HeaderTab(
                icon: AppIcons.info,
                label: LocaleKeys.community_groupDetail_tabDetails.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _ExpandedBackground extends StatelessWidget {
  const _ExpandedBackground({required this.model});

  final GroupModel model;

  static const double _scrimOpacity = 0.75;

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
                  AppColors.navy900.withValues(alpha: _scrimOpacity),
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

final class _HeaderToolbar extends StatelessWidget {
  const _HeaderToolbar({required this.model, required this.titleOpacity});

  final GroupModel model;
  final double titleOpacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _BackButton(),
        const EmptyBox.smallWidth(),
        Expanded(
          child: Opacity(
            opacity: titleOpacity,
            child: GeneralContentTitle(
              value: model.name,
              fontWeight: FontWeight.w700,
              maxLine: AppConstants.kOne,
            ),
          ),
        ),
        if (model.isCurrentUserAdmin)
          const Padding(
            padding: PagePadding.onlyRight(),
            child: _AdminBadge(),
          ),
      ],
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentTitle(
          value: model.name,
          color: AppColors.white,
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
              color: AppColors.white,
            ),
            const EmptyBox(width: WidgetSizes.spacingXxs),
            GeneralContentSmallTitle(value: typeLabel, color: AppColors.white),
            const EmptyBox.smallWidth(),
            const Icon(
              AppIcons.group,
              size: AppIconSizes.xMedium,
              color: AppColors.white,
            ),
            const EmptyBox(width: WidgetSizes.spacingXxs),
            GeneralContentSmallTitle(
              value: LocaleKeys.community_groupDetail_memberCount.tr(
                namedArgs: {'count': model.memberCount.toString()},
              ),
              color: AppColors.white,
            ),
          ],
        ),
      ],
    );
  }
}

final class _BackButton extends StatelessWidget {
  const _BackButton();

  static const double _backgroundOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allVeryLow(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy900.withValues(
            alpha: _backgroundOpacity,
          ),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () => context.pop(),
        child: const Icon(AppIcons.arrowBack, color: AppColors.white),
      ),
    );
  }
}

final class _AdminBadge extends StatelessWidget {
  const _AdminBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.coral,
          borderRadius: CustomRadius.xxLarge,
        ),
        child: Padding(
          padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AppIcons.lockPerson,
                size: AppIconSizes.smallX,
                color: AppColors.white,
              ),
              const EmptyBox(width: WidgetSizes.spacingXxs),
              GeneralContentSmallTitle(
                value: LocaleKeys.community_groupDetail_adminBadge.tr(),
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _HeaderTab extends StatelessWidget {
  const _HeaderTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppIconSizes.xMedium),
          const EmptyBox(width: WidgetSizes.spacingXxs),
          Text(label),
        ],
      ),
    );
  }
}
