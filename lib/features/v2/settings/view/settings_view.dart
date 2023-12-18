import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/settings_module/developers/developers_view.dart';
import 'package:vbaseproject/features/settings_module/settings/subview/notification_permission_checkbox.dart';
import 'package:vbaseproject/features/v2/settings/model/contact_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/constants/string_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/decorations/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/page_app_bar.dart';
import 'package:vbaseproject/product/widget/dropdown/language_dropdown_widget.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

part 'widget/app_about_widget.dart';
part 'widget/change_language_widget.dart';
part 'widget/change_notification_widget.dart';
part 'widget/contact_us_widget.dart';
part 'widget/developers_widget.dart';

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.settings_title,
      ),
      body: CustomScrollView(
        slivers: [
          const EmptyBox.middleHeight().ext.sliver,
          const _DevelopersWidget().ext.sliver,
          const EmptyBox.middleHeight().ext.sliver,
          const _ChangeNotificationWidget().ext.sliver,
          const _ChangeLanguageWidget().ext.sliver,
          const _ContactUsWidget().ext.sliver,
          const EmptyBox.middleHeight().ext.sliver,
          const _AppAboutWidget().ext.sliver,
          const EmptyBox.middleHeight().ext.sliver,
        ],
      ),
    );
  }
}
