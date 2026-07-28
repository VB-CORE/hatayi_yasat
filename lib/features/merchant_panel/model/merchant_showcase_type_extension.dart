import 'package:flutter/widgets.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

extension MerchantShowcaseTypeX on MerchantShowcaseType {
  String get label => switch (this) {
    MerchantShowcaseType.campaign =>
      LocaleKeys.merchantPanel_showcase_typeCampaign,
    MerchantShowcaseType.announcement =>
      LocaleKeys.merchantPanel_showcase_typeAnnouncement,
    MerchantShowcaseType.event => LocaleKeys.merchantPanel_showcase_typeEvent,
  };

  IconData get icon => switch (this) {
    MerchantShowcaseType.campaign => AppIcons.campaign,
    MerchantShowcaseType.announcement => AppIcons.announcement,
    MerchantShowcaseType.event => AppIcons.calendarFilled,
  };

  Color get color => switch (this) {
    MerchantShowcaseType.campaign => AppColors.coral,
    MerchantShowcaseType.announcement => AppColors.navy400,
    MerchantShowcaseType.event => AppColors.teal,
  };

  Color get backgroundColor => switch (this) {
    MerchantShowcaseType.campaign => AppColors.coral50,
    MerchantShowcaseType.announcement => AppColors.navy50,
    MerchantShowcaseType.event => AppColors.teal50,
  };
}
