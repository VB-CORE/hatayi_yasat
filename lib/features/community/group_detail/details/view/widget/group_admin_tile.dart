import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/widget/group_member_avatar.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupAdminTile extends StatelessWidget {
  const GroupAdminTile({required this.model, super.key});

  final GroupMemberModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GroupMemberAvatar(displayName: model.displayName),
        const EmptyBox(width: WidgetSizes.spacingS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralContentSubTitle(
                value: model.displayName,
                fontWeight: FontWeight.w700,
              ),
              GeneralContentSmallTitle(
                value: '@${model.username}',
                color: context.appColors.navy300,
              ),
            ],
          ),
        ),
        GeneralStatusBadge(
          label: LocaleKeys.community_groupDetail_adminBadge.tr(),
          color: context.general.colorScheme.tertiary,
          icon: AppIcons.lockPerson,
        ),
      ],
    );
  }
}
