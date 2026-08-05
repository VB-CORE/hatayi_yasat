import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';

final class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService({
    FirebaseAnalytics? analytics,
    FirebaseCrashlytics? crashlytics,
  }) : _analytics = analytics ?? FirebaseAnalytics.instance,
       _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;

  /// Debug builds share the single production Firebase project, so collection
  /// stays off unless a developer opts in with
  /// `--dart-define=ANALYTICS_DEBUG=true`.
  static const bool _debugOverride = bool.fromEnvironment('ANALYTICS_DEBUG');

  static bool get isEnabled => !kDebugMode || _debugOverride;

  @override
  Future<void> logEvent(
    AnalyticsEvent event, {
    Map<AnalyticsParameter, Object?> parameters = const {},
  }) async {
    if (!isEnabled) return;
    final payload = _sanitize(parameters);
    await _crashlytics.log(
      payload.isEmpty ? event.key : '${event.key} $payload',
    );
    await _analytics.logEvent(
      name: event.key,
      parameters: payload.isEmpty ? null : payload,
    );
  }

  @override
  Future<void> logScreenView(String screenName) async {
    if (!isEnabled) return;
    await _crashlytics.log('screen_view $screenName');
    await _analytics.logScreenView(screenName: screenName);
  }

  @override
  Future<void> setUser(
    UserModel? user, {
    required AnalyticsAuthStatus status,
  }) async {
    if (!isEnabled) return;
    // Only the uid crosses over; GA4 forbids PII like email and displayName.
    final uid = user?.uid.isNotEmpty ?? false ? user!.uid : null;
    await _analytics.setUserId(id: uid);
    await _crashlytics.setUserIdentifier(uid ?? '');

    await setUserProperty(AnalyticsUserProperty.authStatus, status.key);
    await setUserProperty(AnalyticsUserProperty.userRole, user?.roleType.name);
    await setUserProperty(
      AnalyticsUserProperty.isMerchant,
      user == null ? null : '${user.merchantStoreId != null}',
    );
  }

  @override
  Future<void> setUserProperty(
    AnalyticsUserProperty property,
    String? value,
  ) async {
    if (!isEnabled) return;
    await _analytics.setUserProperty(name: property.key, value: value);
    await _crashlytics.setCustomKey(property.key, value ?? '');
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  }) async {
    if (!isEnabled) return;
    await _crashlytics.recordError(
      error,
      stackTrace,
      fatal: fatal,
      reason: reason,
    );
  }

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  /// Coerces to the `String`/`num` pair `logEvent` accepts, so call sites can
  /// pass bools and enums directly.
  Map<String, Object> _sanitize(Map<AnalyticsParameter, Object?> parameters) {
    final result = <String, Object>{};
    for (final entry in parameters.entries) {
      final value = entry.value;
      if (value == null) continue;
      result[entry.key.key] = value is num ? value : '$value';
    }
    return result;
  }
}
