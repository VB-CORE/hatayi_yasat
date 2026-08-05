import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/main/settings/model/contact_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/checkbox/notification_permission_checkbox.dart';
import 'package:lifeclient/product/widget/general/general_segmented_control.dart';
import 'package:lifeclient/product/widget/menu/content_menu.dart';

part 'widget/change_language_widget.dart';
part 'widget/contact_us_widget.dart';

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(pageTitle: LocaleKeys.settings_title),
      body: ListView(
        padding:
            const PagePadding.allLow() +
            .only(bottom: context.general.mediaQuery.padding.bottom),
        children: [
          Text(
            LocaleKeys.settings_notificationTitle.tr().toUpperCase(),
            style: AppText.body.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.navy500,
            ),
          ),
          const EmptyBox.smallHeight(),
          const NotificationPermissionView(),
          const EmptyBox.middleHeight(),
          Text(
            LocaleKeys.settings_languageTitle.tr().toUpperCase(),
            style: AppText.body.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.navy500,
            ),
          ),
          const EmptyBox.smallHeight(),
          const _ChangeLanguageWidget(),
          const EmptyBox.middleHeight(),
          Text(
            LocaleKeys.settings_contactTitle.tr().toUpperCase(),
            style: AppText.body.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.navy500,
            ),
          ),
          const EmptyBox.smallHeight(),
          const _ContactUsWidget(),
        ],
      ),
    );
  }
}
