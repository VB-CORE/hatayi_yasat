import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class PageAppBar extends AppBar {
  PageAppBar({
    required String pageTitle,
    bool showDivider = true,
    super.actions,
    super.automaticallyImplyLeading,
    super.actionsPadding,
    super.backgroundColor,
    super.centerTitle = false,
    super.key,
  }) : super(
         bottom: showDivider
             ? PreferredSize(
                 preferredSize: const Size.fromHeight(WidgetSizes.spacingXSs),
                 child: Divider(
                   height: AppConstants.kOne.toDouble(),
                 ),
               )
             : null,
         title: GeneralContentTitle(
           value: pageTitle.tr(),
           fontWeight: FontWeight.w500,
         ),
       );
}
