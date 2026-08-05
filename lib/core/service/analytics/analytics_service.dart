import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';

/// Single entry point for product telemetry.
///
/// Both Analytics and Crashlytics sit behind this so a screen or an event is
/// reported once and shows up as a metric *and* as a crash breadcrumb.
abstract interface class AnalyticsService {
  Future<void> logEvent(
    AnalyticsEvent event, {
    Map<AnalyticsParameter, Object?> parameters = const {},
  });

  Future<void> logScreenView(String screenName);

  /// Identifies the current account. Passing a null [user] clears the identity
  /// and marks the session as [AnalyticsAuthStatus.guest].
  Future<void> setUser(UserModel? user, {required AnalyticsAuthStatus status});

  Future<void> setUserProperty(AnalyticsUserProperty property, String? value);

  /// Reports a handled failure. Defaults to non-fatal because the call sites
  /// are the `FirebaseFailure` branches that would otherwise be swallowed.
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  });

  Future<void> setCollectionEnabled({required bool enabled});
}
