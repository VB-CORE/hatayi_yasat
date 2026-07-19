import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class AdminVerifiedBadge extends StatelessWidget {
  const AdminVerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralStatusBadge(
      label: LocaleKeys.admin_verifiedMerchant.tr(),
      color: context.general.colorScheme.primary,
      icon: AppIcons.verifiedUser,
    );
  }
}
