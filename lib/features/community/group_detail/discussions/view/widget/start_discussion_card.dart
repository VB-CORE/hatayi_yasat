import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class StartDiscussionCard extends StatelessWidget {
  const StartDiscussionCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tertiary = context.general.colorScheme.tertiary;
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: tertiary,
        radius: context.border.normalRadius,
        dashPattern: const [3, 6],
        strokeCap: StrokeCap.square,
      ),
      child: ClipRRect(
        borderRadius: CustomRadius.medium,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const PagePadding.generalCardAll(),
            child: Row(
              children: [
                SoftIconBox(
                  icon: AppIcons.forum,
                  iconColor: tertiary,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralContentSubTitle(
                        value: LocaleKeys
                            .community_groupDetail_discussions_startTitle
                            .tr(),
                        fontWeight: FontWeight.w700,
                      ),
                      GeneralContentSmallTitle(
                        value: LocaleKeys
                            .community_groupDetail_discussions_startSubtitle
                            .tr(),
                        color: context.appColors.navy300,
                      ),
                    ],
                  ),
                ),
                Icon(AppIcons.add, color: tertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
