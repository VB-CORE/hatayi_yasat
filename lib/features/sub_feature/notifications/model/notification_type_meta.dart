import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class NotificationTypeMeta extends Equatable {
  const NotificationTypeMeta({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
  });

  factory NotificationTypeMeta.of(
    AppNotificationType? type,
    BuildContext context,
  ) {
    return switch (type) {
      AppNotificationType.store => NotificationTypeMeta(
        icon: AppIcons.store,
        label: LocaleKeys.notification_typePlace.tr(),
        color: context.appColors.coral50,
        iconColor: context.appColors.coral,
      ),
      AppNotificationType.campaign => NotificationTypeMeta(
        icon: AppIcons.localActivity,
        label: LocaleKeys.notification_typeEvent.tr(),
        color: context.appColors.teal50,
        iconColor: context.appColors.teal,
      ),
      AppNotificationType.news ||
      AppNotificationType.advertise ||
      AppNotificationType.link ||
      null => NotificationTypeMeta(
        icon: AppIcons.announcement,
        label: LocaleKeys.notification_typeSystem.tr(),
        color: context.appColors.navy50,
        iconColor: context.appColors.navy,
      ),
    };
  }

  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;

  @override
  List<Object> get props => [icon, label, color, iconColor];
}
