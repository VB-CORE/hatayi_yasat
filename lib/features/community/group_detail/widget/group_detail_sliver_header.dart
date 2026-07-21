import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
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

part 'sliver_header/expanded_background.dart';
part 'sliver_header/header_toolbar.dart';

@immutable
final class GroupDetailSliverHeader extends StatelessWidget {
  const GroupDetailSliverHeader({
    required this.model,
    required this.isCurrentUserAdmin,
    super.key,
  });

  final GroupModel model;
  final bool isCurrentUserAdmin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final surface = context.appColors.surface;
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL14,
      pinned: true,
      backgroundColor: surface,
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(builder: _buildFlexibleSpace),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: ColoredBox(
          color: surface,
          child: TabBar(
            labelColor: colorScheme.tertiary,
            unselectedLabelColor: context.appColors.navy300,
            indicatorColor: colorScheme.tertiary,
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

  Widget _buildFlexibleSpace(BuildContext context, BoxConstraints constraints) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final expandRatio = _expandRatioOf(constraints, topPadding);
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
            isCurrentUserAdmin: isCurrentUserAdmin,
            titleOpacity: 1 - expandRatio,
          ),
        ),
      ],
    );
  }

  /// Header'ın ne kadar açık olduğu: 1 tamamen genişlemiş, 0 tamamen toplanmış.
  double _expandRatioOf(BoxConstraints constraints, double topPadding) {
    final collapsedHeight = topPadding + kToolbarHeight + kTextTabBarHeight;
    final maxExtent = WidgetSizes.spacingXxlL14 + topPadding;
    if (maxExtent <= collapsedHeight) return 0;
    return ((constraints.maxHeight - collapsedHeight) /
            (maxExtent - collapsedHeight))
        .clamp(0.0, 1.0);
  }
}
