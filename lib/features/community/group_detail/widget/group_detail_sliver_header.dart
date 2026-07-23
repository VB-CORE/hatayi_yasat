import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:lifeclient/features/community/widget/group_cover_image.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'sliver_header/collapsing_header_space.dart';
part 'sliver_header/expanded_background.dart';
part 'sliver_header/header_toolbar.dart';

@immutable
final class GroupDetailSliverHeader extends StatelessWidget {
  const GroupDetailSliverHeader({required this.model, super.key});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final surface = context.appColors.surface;
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL14,
      pinned: true,
      backgroundColor: surface,
      automaticallyImplyLeading: false,
      flexibleSpace: _CollapsingHeaderSpace(model: model),
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
}
