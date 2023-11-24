import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/favorite_places/view/favorite_places_view.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

part '../popup/custom_popup_item.dart';

final class CustomAppBar extends AppBar {
  CustomAppBar({
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
          title: Text(
            LocaleKeys.project_name,
            style: context.general.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).tr(context: context),
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
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.specialAgency_title,
            context: context,
            destination: const SpecialAgencyView(),
          ),
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.favoritePlaces_title,
            context: context,
            destination: const FavoritePlacesView(),
          ),
        ];
      },
    );
  }
}
