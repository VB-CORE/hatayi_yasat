import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      icon: AppIcons.info,
      title: LocaleKeys.general_error_title.tr(),
      description: LocaleKeys.general_error_description.tr(),
      iconBackgroundColor: context.appColors.coral50,
      iconColor: context.appColors.coral,
      action: GeneralButtonV2.active(
        action: onRetry,
        label: LocaleKeys.general_error_retry.tr(),
        icon: AppIcons.hourglass,
        backgroundColor: context.appColors.navy,
      ),
    );
  }
}
