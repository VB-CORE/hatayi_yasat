import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';
import 'package:vbaseproject/features/v2/favorite/view/favorite_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/widget/general/general_content_sub_title.dart';
import 'package:vbaseproject/product/widget/general/title/general_sub_title.dart';
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
            context: context,
            destination: const SpecialAgencyView(),
          ),
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.favorite_title,
            context: context,
            destination: const FavoriteView(),
          ),
        ];
      },
    );
  }
}
