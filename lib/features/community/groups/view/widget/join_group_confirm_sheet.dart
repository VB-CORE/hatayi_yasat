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
final class JoinGroupConfirmSheet extends StatelessWidget {
  const JoinGroupConfirmSheet._();

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: CustomRadius.large.topLeft),
      ),
      builder: (context) => const JoinGroupConfirmSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontal16Symmetric(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SoftIconBox(
                  icon: AppIcons.personAdd,
                  iconColor: context.general.colorScheme.primary,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: GeneralContentTitle(
                    value: LocaleKeys.community_groups_joinConfirmTitle.tr(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const EmptyBox.middleHeight(),
            GeneralContentSubTitle(
              value: LocaleKeys.community_groups_joinConfirmMessage.tr(),
              color: context.appColors.navy400,
            ),
            const EmptyBox.largeHeight(),
            GeneralButtonV2.async(
              action: () async => Navigator.of(context).pop(true),
              label: LocaleKeys.community_groups_join.tr(),
              icon: AppIcons.personAdd,
            ),
            const EmptyBox.smallHeight(),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  LocaleKeys.community_groups_joinConfirmCancel.tr(),
                ),
              ),
            ),
            const EmptyBox.smallHeight(),
          ],
        ),
      ),
    );
  }
}
