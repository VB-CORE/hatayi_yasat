import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/init/core_localize.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/main/settings/model/contact_model.dart';
import 'package:lifeclient/features/sub_feature/web_view/app_about_web_view.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/package/app_review/app_review.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/package/settings/custom_app_settings.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
import 'package:lifeclient/product/widget/dialog/v2_delete_account_dialog.dart';
import 'package:lifeclient/product/widget/dialog/v2_logout_dialog.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:permission_handler/permission_handler.dart';

part 'widget/auth_prompt_widget.dart';
part 'widget/city_switcher_widget.dart';
part 'widget/contact_us_widget.dart';
part 'widget/general_tiles_group.dart';
part 'widget/support_tiles_group.dart';
part 'widget/v2_setting_tile.dart';

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: AppBar(
        backgroundColor: context.general.colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          LocaleKeys.settings_title.tr(context: context),
          style: V2Typography.display(
            fontSize: 22,
            color: context.general.colorScheme.primary,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.list(
            children: [
              const EmptyBox.middleHeight(),
              const _AuthPromptWidget(),
              const EmptyBox.smallHeight(),
              _SettingsSectionLabel(LocaleKeys.settingsV2_groupCity.tr()),
              const _CitySwitcherWidget(),
              const EmptyBox.smallHeight(),
              _SettingsSectionLabel(
                LocaleKeys.settingsV2_groupPreferences.tr(),
              ),
              const _GeneralTilesGroup(),
              const EmptyBox.middleHeight(),
              _SettingsSectionLabel(LocaleKeys.settingsV2_groupSupport.tr()),
              const _SupportTilesGroup(),
              const EmptyBox.middleHeight(),
              _SettingsSectionLabel(LocaleKeys.settingsV2_groupAccount.tr()),
              const _AccountTilesGroup(),
              const EmptyBox.smallHeight(),
              const _SignOutTile(),
              const EmptyBox(
                height: WidgetSizes.spacingXxl8 + WidgetSizes.spacingXxl2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
