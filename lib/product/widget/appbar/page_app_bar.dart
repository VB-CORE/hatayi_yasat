import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class PageAppBar extends AppBar {
  PageAppBar({
    required BuildContext context,
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
          // TODO: Fix => PR birleşince General text widget olarak değiştirilecek.
          title: Text(
            pageTitle.tr(),
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
}
