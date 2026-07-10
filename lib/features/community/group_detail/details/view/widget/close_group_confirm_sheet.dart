import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/widget/community_submit_button.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

/// Grubu kapatma onayı — geri alınamaz aksiyon için bottom sheet.
@immutable
final class CloseGroupConfirmSheet extends StatelessWidget {
  const CloseGroupConfirmSheet({super.key});

  /// Kullanıcı onaylarsa `true`, vazgeçer/kapatırsa `null` döner.
  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: CustomRadius.large.topLeft),
      ),
      builder: (context) => const CloseGroupConfirmSheet(),
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
                const SoftIconBox(
                  icon: AppIcons.delete,
                  iconColor: AppColors.coral,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: GeneralContentTitle(
                    value: LocaleKeys
                        .community_groupDetail_details_closeGroupConfirmTitle
                        .tr(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const EmptyBox.middleHeight(),
            GeneralContentSubTitle(
              value: LocaleKeys
                  .community_groupDetail_details_closeGroupConfirmMessage
                  .tr(),
              color: AppColors.navy400,
            ),
            const EmptyBox.largeHeight(),
            CommunitySubmitButton(
              label: LocaleKeys.community_groupDetail_details_closeGroup.tr(),
              icon: AppIcons.delete,
              isEnabled: true,
              onPressed: () async => Navigator.of(context).pop(true),
            ),
            const EmptyBox.smallHeight(),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  LocaleKeys
                      .community_groupDetail_details_closeGroupConfirmCancel
                      .tr(),
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
