import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

@immutable
final class PageAppBar extends AppBar {
  PageAppBar({
    required String pageTitle,
    super.actions,
    super.automaticallyImplyLeading,
    super.key,
  }) : super(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(WidgetSizes.spacingXSs),
            child: Divider(
              height: AppConstants.kOne.toDouble(),
            ),
          ),
          title: GeneralContentTitle(
            value: pageTitle.tr(),
            fontWeight: FontWeight.bold,
          ),
        );
}
