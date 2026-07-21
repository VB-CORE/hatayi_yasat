import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupDiscussionTile extends StatelessWidget {
  const GroupDiscussionTile({
    required this.model,
    required this.onTap,
    super.key,
  });

  final GroupDiscussionModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final navy300 = context.appColors.navy300;
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomRadius.large,
        child: Padding(
          padding: const PagePadding.generalCardAll(),
          child: Row(
            children: [
              SoftIconBox(
                icon: AppIcons.forum,
                iconColor: context.appColors.navy400,
                backgroundColor: context.appColors.navy700,
                backgroundOpacity: 0.08,
              ),
              const EmptyBox(width: WidgetSizes.spacingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralContentSubTitle(
                      value: model.title,
                      fontWeight: FontWeight.w700,
                      maxLine: AppConstants.kTwo,
                    ),
                    const EmptyBox.xxSmallHeight(),
                    GeneralContentSmallTitle(
                      value: LocaleKeys.community_groupDetail_discussions_meta
                          .tr(
                            args: [
                              model.author.maskedDisplayName,
                              model.createdAt.timeAgo,
                              model.entryCount.toString(),
                            ],
                          ),
                      color: navy300,
                      maxLine: AppConstants.kOne,
                    ),
                  ],
                ),
              ),
              Icon(AppIcons.rightSelect, color: navy300),
            ],
          ),
        ),
      ),
    );
  }
}
