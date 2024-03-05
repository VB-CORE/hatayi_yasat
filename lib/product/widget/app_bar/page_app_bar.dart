import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/widget/general/index.dart';

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
          centerTitle: false,
          title: GeneralContentTitle(
            value: pageTitle.tr(),
            fontWeight: FontWeight.bold,
          ),
        );
}
