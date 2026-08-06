import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';

/// Single entry point for product telemetry.
///
/// Both Analytics and Crashlytics sit behind this so a screen or an event is
/// reported once and shows up as a metric *and* as a crash breadcrumb.
///
/// Every reporting method returns `void` on purpose: telemetry must never sit
/// on a user flow, so callers are not handed a future they could await. The
/// implementation absorbs its own failures.
abstract interface class AnalyticsService {
  void logEvent(
    AnalyticsEvent event, {
    Map<AnalyticsParameter, Object?> parameters = const {},
  });

  void logScreenView(String screenName);

  /// Identifies the current account. Passing a null [user] clears the identity
  /// and marks the session as [AnalyticsAuthStatus.guest].
  void setUser(UserModel? user, {required AnalyticsAuthStatus status});

  void setUserProperty(AnalyticsUserProperty property, String? value);

  /// Reports a handled failure. Defaults to non-fatal because the call sites
  /// are the `FirebaseFailure` branches that would otherwise be swallowed.
  void recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  });

  /// The one awaitable method: it has to settle during startup, before the
  /// route observer starts reporting screens straight to `FirebaseAnalytics`.
  Future<void> setCollectionEnabled({required bool enabled});
}
