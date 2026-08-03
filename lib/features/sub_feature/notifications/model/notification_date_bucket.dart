import 'package:easy_localization/easy_localization.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';

enum NotificationDateBucket { today, yesterday, older }

extension NotificationDateBucketOf on DateTime {
  NotificationDateBucket get notificationDateBucket {
    final days = DateTime.now().startOfDay.difference(startOfDay).inDays;
    return switch (days) {
      0 => NotificationDateBucket.today,
      1 => NotificationDateBucket.yesterday,
      _ => NotificationDateBucket.older,
    };
  }
}

extension NotificationDateBucketLabel on NotificationDateBucket {
  String get label => switch (this) {
    NotificationDateBucket.today => LocaleKeys.date_today.tr(),
    NotificationDateBucket.yesterday => LocaleKeys.date_yesterday.tr(),
    NotificationDateBucket.older => LocaleKeys.date_earlier.tr(),
  };
}
