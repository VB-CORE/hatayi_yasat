import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class NotificationTypeMeta extends Equatable {
  const NotificationTypeMeta({required this.icon, required this.label});

  factory NotificationTypeMeta.of(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.store => NotificationTypeMeta(
        icon: AppIcons.home,
        label: LocaleKeys.notification_typeStore.tr(),
      ),
      AppNotificationType.campaign => NotificationTypeMeta(
        icon: AppIcons.discount,
        label: LocaleKeys.notification_typeCampaign.tr(),
      ),
      AppNotificationType.news => NotificationTypeMeta(
        icon: AppIcons.textSnippet,
        label: LocaleKeys.notification_typeNews.tr(),
      ),
      AppNotificationType.advertise => NotificationTypeMeta(
        icon: AppIcons.notifications,
        label: LocaleKeys.notification_typeAdvertise.tr(),
      ),
      AppNotificationType.link => NotificationTypeMeta(
        icon: AppIcons.openInNew,
        label: LocaleKeys.notification_typeLink.tr(),
      ),
    };
  }

  final IconData icon;
  final String label;

  @override
  List<Object> get props => [icon, label];
}
