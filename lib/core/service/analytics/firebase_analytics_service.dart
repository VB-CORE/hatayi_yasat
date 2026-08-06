import 'dart:async';

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

  bool _isReportingFailure = false;

  @override
  void logEvent(
    AnalyticsEvent event, {
    Map<AnalyticsParameter, Object?> parameters = const {},
  }) {
    if (!isEnabled) return;
    final payload = _sanitize(parameters);
    _fireAndForget(event.key, () async {
      await _crashlytics.log(
        payload.isEmpty ? event.key : '${event.key} $payload',
      );
      await _analytics.logEvent(
        name: event.key,
        parameters: payload.isEmpty ? null : payload,
      );
    });
  }

  @override
  void logScreenView(String screenName) {
    if (!isEnabled) return;
    _fireAndForget('screen_view', () async {
      await _crashlytics.log('screen_view $screenName');
      await _analytics.logScreenView(screenName: screenName);
    });
  }

  @override
  void setUser(UserModel? user, {required AnalyticsAuthStatus status}) {
    if (!isEnabled) return;
    // Only the uid crosses over; GA4 forbids PII like email and displayName.
    final uid = user?.uid.isNotEmpty ?? false ? user!.uid : null;
    _fireAndForget('set_user', () async {
      await _analytics.setUserId(id: uid);
      await _crashlytics.setUserIdentifier(uid ?? '');
    });

    setUserProperty(AnalyticsUserProperty.authStatus, status.key);
    setUserProperty(AnalyticsUserProperty.userRole, user?.roleType.name);
    setUserProperty(
      AnalyticsUserProperty.isMerchant,
      user == null ? null : '${user.merchantStoreId != null}',
    );
  }

  @override
  void setUserProperty(AnalyticsUserProperty property, String? value) {
    if (!isEnabled) return;
    _fireAndForget(property.key, () async {
      await _analytics.setUserProperty(name: property.key, value: value);
      await _crashlytics.setCustomKey(property.key, value ?? '');
    });
  }

  @override
  void recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  }) {
    if (!isEnabled) return;
    _fireAndForget('record_error', () async {
      await _crashlytics.recordError(
        error,
        stackTrace,
        fatal: fatal,
        reason: reason,
      );
    });
  }

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  /// Runs [action] detached from the caller.
  ///
  /// The catch is what makes that safe: an unhandled async error would reach
  /// `PlatformDispatcher.onError` and be filed as a *fatal* crash, so a hiccup
  /// in telemetry would masquerade as an app crash.
  void _fireAndForget(String operation, Future<void> Function() action) {
    unawaited(_run(operation, action));
  }

  Future<void> _run(String operation, Future<void> Function() action) async {
    try {
      await action();
    } on Object catch (error, stackTrace) {
      await _reportFailure(operation, error, stackTrace);
    }
  }

  /// Reports the failure as non-fatal. Guarded against re-entry because the
  /// failing dependency may well be Crashlytics itself.
  Future<void> _reportFailure(
    String operation,
    Object error,
    StackTrace stackTrace,
  ) async {
    if (_isReportingFailure) return;
    _isReportingFailure = true;
    try {
      await _crashlytics.recordError(
        error,
        stackTrace,
        reason: 'analytics.$operation',
      );
    } on Object {
      // Nothing left to report to; losing telemetry must stay silent.
    } finally {
      _isReportingFailure = false;
    }
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
