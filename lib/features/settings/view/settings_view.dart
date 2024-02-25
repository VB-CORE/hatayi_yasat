import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/settings/model/contact_model.dart';
import 'package:vbaseproject/features/sub_feature/web_view/app_about_web_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/settings_router/settings_router.dart';
import 'package:vbaseproject/product/package/app_review/app_review.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/constants/string_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/decorations/index.dart';
import 'package:vbaseproject/product/widget/checkbox/notification_permission_checkbox.dart';
import 'package:vbaseproject/product/widget/dropdown/language_dropdown_widget.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/rating/app_rating_widget.dart';

part 'widget/app_about_widget.dart';
part 'widget/change_language_widget.dart';
part 'widget/change_notification_widget.dart';
part 'widget/contact_us_widget.dart';
part 'widget/developers_widget.dart';
part 'widget/rating_widget.dart';

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: CustomScrollView(
        slivers: [
          const EmptyBox.middleHeight().ext.sliver,
          const _DevelopersWidget().ext.sliver,
          const _ChangeNotificationWidget().ext.sliver,
          const _ChangeLanguageWidget().ext.sliver,
          const _ContactUsWidget().ext.sliver,
          const Divider().ext.sliver,
          const _AppAboutWidget().ext.sliver,
          const _RatingWidget().ext.sliver,
          // bottomNavigationBar height = 60 = WidgetSizes.spacingXxl8
          // FabButton height = WidgetSizes.spacingXxl2
          const EmptyBox(
            height: WidgetSizes.spacingXxl8 + WidgetSizes.spacingXxl2,
          ).ext.sliver,
        ],
      ),
    );
  }
}
