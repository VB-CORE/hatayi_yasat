import 'dart:async' show unawaited;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/settings/model/contact_model.dart';
import 'package:lifeclient/features/sub_feature/web_view/app_about_web_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/settings_router/settings_router.dart';
import 'package:lifeclient/product/package/app_review/app_review.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/widget/checkbox/notification_permission_checkbox.dart';
import 'package:lifeclient/product/widget/dialog/changing_dialog.dart';
import 'package:lifeclient/product/widget/dropdown/language_dropdown_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/sub_feature/city/provider/city_view_model.dart';

part 'widget/app_about_widget.dart';
part 'widget/change_language_widget.dart';
part 'widget/change_notification_widget.dart';
part 'widget/choose_location_widget.dart';
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
          SliverList.list(
            children: [
              const EmptyBox.middleHeight(),
              const _DevelopersWidget(),
              _ChooseLocationWidget(
                cities: [
                  /// TODO: Firebase'den alınacak.
                  TownModel(
                    code: 31,
                    name: 'Hatay',
                    documentId: '1',
                  ),
                  TownModel(
                    code: 33,
                    name: 'Mersin',
                    documentId: '2',
                  ),
                ],
              ),
              const _ChangeNotificationWidget(),
              const _ChangeLanguageWidget(),
              const _ContactUsWidget(),
              const _AppAboutWidget(),
              const _RatingWidget(),
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
