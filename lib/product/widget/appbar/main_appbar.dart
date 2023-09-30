import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';
import 'package:vbaseproject/features/settings_module/settings/settings_view.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/widget/button/appbar_icon_button.dart';

final class MainAppBar extends AppBar {
  MainAppBar({
    required BuildContext context,
    super.key,
  }) : super(
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(WidgetSizes.spacingXSS),
            child: Divider(),
          ),
          title: const Text(LocaleKeys.project_name).tr(context: context),
          actions: const [
            AppbarIconButton(
              iconData: Icons.maps_home_work_outlined,
              destination: SpecialAgencyView(),
            ),
            AppbarIconButton(
              iconData: Icons.notifications_active_outlined,
              destination: NotificationsView(),
            ),
            AppbarIconButton(
              iconData: Icons.settings_outlined,
              destination: SettingsView(),
            ),
          ],
        );
}
