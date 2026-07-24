import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/settings/model/contact_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/product/widget/checkbox/notification_permission_checkbox.dart';
import 'package:lifeclient/product/widget/dropdown/language_dropdown_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/change_language_widget.dart';
part 'widget/change_notification_widget.dart';
part 'widget/change_theme_widget.dart';
part 'widget/contact_us_widget.dart';

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: AppBar(
        title: GeneralSubTitle(
          value: LocaleKeys.settings_title.tr(context: context),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.list(
            children: const [
              EmptyBox.middleHeight(),
              _ChangeNotificationWidget(),
              _ChangeLanguageWidget(),
              _ChangeThemeWidget(),
              _ContactUsWidget(),
              EmptyBox(
                height: WidgetSizes.spacingXxl8 + WidgetSizes.spacingXxl2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
