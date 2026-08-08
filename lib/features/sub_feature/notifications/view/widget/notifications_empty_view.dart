import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class NotificationsEmptyView extends StatelessWidget {
  const NotificationsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppConstants.kSeventyTwo,
              height: AppConstants.kSeventyTwo,
              decoration: BoxDecoration(
                color: context.appColors.ink100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                AppIcons.notificationsOff,
                size: AppIconSizes.large,
                color: context.appColors.ink400,
              ),
            ),
            const EmptyBox.middleHeight(),
            GeneralContentTitle(
              value: LocaleKeys.notFound_notification.tr(),
            ),
            const EmptyBox.smallHeight(),
            GeneralContentSubTitle(
              value: LocaleKeys.notFound_notificationDescription.tr(),
              color: context.appColors.ink400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
