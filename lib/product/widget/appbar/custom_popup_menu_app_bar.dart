import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/agency_router/agency_router.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/favorite_router/favorite_router.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

part '../popup/custom_popup_item.dart';

final class CustomPopupMenuAppbar extends AppBar {
  CustomPopupMenuAppbar({
    required BuildContext context,
    super.key,
  }) : super(
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
            child: Divider(
              height: AppConstants.kOne.toDouble(),
            ),
          ),
          title: GeneralSubTitle(
            value: LocaleKeys.project_name.tr(context: context),
            fontWeight: FontWeight.bold,
          ),
          actions: [
            const _CustomPopupMenu(),
          ],
        );
}

final class _CustomPopupMenu extends StatelessWidget {
  const _CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        AppIcons.moreDots,
        color: context.general.colorScheme.primary,
      ),
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.specialAgency_title,
            destination: () {
              const SpecialAgencyRoute().push<SpecialAgencyRoute>(context);
            },
          ),
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.favorite_title,
            destination: () {
              const FavoriteRoute().push<FavoriteRoute>(context);
            },
          ),
        ];
      },
    );
  }
}
