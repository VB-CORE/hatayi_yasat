import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

enum MerchantPanelTab {
  dashboard(
    label: LocaleKeys.merchantPanel_tabs_dashboard,
    icon: AppIcons.gridView,
    selectedIcon: AppIcons.gridView,
  ),
  reviews(
    label: LocaleKeys.merchantPanel_tabs_reviews,
    icon: AppIcons.comment,
    selectedIcon: AppIcons.forum,
  ),
  showcase(
    label: LocaleKeys.merchantPanel_tabs_showcase,
    icon: AppIcons.announcement,
    selectedIcon: AppIcons.announcement,
  ),
  store(
    label: LocaleKeys.merchantPanel_tabs_store,
    icon: AppIcons.store,
    selectedIcon: AppIcons.storeFilled,
  )
  ;

  const MerchantPanelTab({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
