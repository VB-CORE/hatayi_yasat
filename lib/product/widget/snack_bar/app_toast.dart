import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class AppToast extends SnackBar {
  AppToast({
    required String messageKey,
    IconData icon = AppIcons.checkFilled,
    super.key,
  }) : super(
         behavior: SnackBarBehavior.floating,
         backgroundColor: AppColors.navy,
         elevation: WidgetSizes.zero,
         duration: _duration,
         margin: const PagePadding.all(),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(AppRadius.md),
         ),
         content: Row(
           spacing: AppSpacing.xs,
           children: [
             Icon(icon, color: AppColors.teal300),
             Expanded(
               child: GeneralContentSubTitle(
                 value: messageKey.tr(),
                 color: AppColors.white,
               ),
             ),
           ],
         ),
       );

  static const Duration _duration = Duration(milliseconds: 1900);

  static void show(BuildContext context, String messageKey, {IconData? icon}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        AppToast(
          messageKey: messageKey,
          icon: icon ?? AppIcons.checkFilled,
        ),
      );
  }
}
