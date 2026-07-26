import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/model/group_type.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

extension GroupTypePresentation on GroupType {
  String get label => switch (this) {
    GroupType.open => LocaleKeys.community_groups_openGroup.tr(),
    GroupType.closed => LocaleKeys.community_groups_closedGroup.tr(),
  };

  IconData get icon => switch (this) {
    GroupType.open => AppIcons.globe,
    GroupType.closed => AppIcons.lockPerson,
  };

  Color badgeColor(BuildContext context) => switch (this) {
    GroupType.open => context.appColors.olive600,
    GroupType.closed => context.appColors.navy400,
  };
}
