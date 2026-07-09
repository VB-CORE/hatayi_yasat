import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/features/community/widget/group_member_avatar.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class DiscussionEntryTile extends StatelessWidget {
  const DiscussionEntryTile({required this.model, super.key});

  final GroupDiscussionEntryModel model;

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
            Row(
              children: [
                GroupMemberAvatar(
                  displayName: model.author.displayName,
                  backgroundColor: AppColors.ink300,
                  singleLetter: true,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GeneralContentSubTitle(
                            value: model.author.maskedDisplayName,
                            fontWeight: FontWeight.w700,
                          ),
                          if (model.author.role == GroupMemberRole.admin) ...[
                            const EmptyBox.smallWidth(),
                            GeneralStatusBadge(
                              label: LocaleKeys.community_groupDetail_adminBadge
                                  .tr(),
                              color: AppColors.coral500,
                            ),
                          ],
                        ],
                      ),
                      GeneralContentSmallTitle(
                        value: model.createdAt.timeAgo,
                        color: AppColors.navy300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const EmptyBox.smallHeight(),
            GeneralContentSubTitle(value: model.content),
          ],
        ),
      ),
    );
  }
}
