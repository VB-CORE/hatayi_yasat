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

extension NullableNotificationDateBucketOf on DateTime? {
  NotificationDateBucket get notificationDateBucketOrNow =>
      (this ?? DateTime.now()).notificationDateBucket;
}

extension NotificationDateBucketLabel on NotificationDateBucket {
  String get labelKey => switch (this) {
    NotificationDateBucket.today => LocaleKeys.date_today,
    NotificationDateBucket.yesterday => LocaleKeys.date_yesterday,
    NotificationDateBucket.older => LocaleKeys.date_earlier,
  };
}
