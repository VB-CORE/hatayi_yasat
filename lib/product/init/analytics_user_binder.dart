import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';

/// Mirrors the signed-in account onto Analytics and Crashlytics so every event
/// and every crash carries the segment it came from.
final class AnalyticsUserBinder {
  AnalyticsUserBinder(Ref ref) {
    _sync(ref.read(authViewModelProvider));
    ref.listen(authViewModelProvider, (previous, next) {
      if (previous != null && !_isIdentityChanged(previous, next)) return;
      _sync(next);
    });
  }

  final AnalyticsService _analyticsService =
      ProjectDependencyItems.analyticsService;

  /// Loading and error states describe an attempt, not an identity — syncing
  /// on them would clear the user id mid sign-in.
  static bool _isIdentityChanged(AuthState previous, AuthState next) {
    if (next is AuthLoading || next is AuthError) return false;
    return previous.user?.uid != next.user?.uid ||
        previous.analyticsStatus != next.analyticsStatus ||
        previous.user?.roleType != next.user?.roleType;
  }

  void _sync(AuthState state) {
    unawaited(
      _analyticsService.setUser(state.user, status: state.analyticsStatus),
    );
  }
}

extension _AnalyticsAuthStatusX on AuthState {
  AnalyticsAuthStatus get analyticsStatus => switch (this) {
    Authenticated() => AnalyticsAuthStatus.loggedIn,
    AuthBanned() => AnalyticsAuthStatus.banned,
    _ => AnalyticsAuthStatus.guest,
  };
}

final Provider<AnalyticsUserBinder> analyticsUserBinderProvider =
    Provider<AnalyticsUserBinder>(AnalyticsUserBinder.new);
