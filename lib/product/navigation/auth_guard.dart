import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

abstract final class AuthGuard {
  const AuthGuard._();

  static String? requireLogin(BuildContext context, GoRouterState state) =>
      _authState(context) is Authenticated ? null : _loginLocation(state);

  static String? redirectIfSignedIn(
    BuildContext context,
    GoRouterState state, {
    String? to,
  }) => _authState(context) is Authenticated
      ? (to ?? const MainTabRoute().location)
      : null;

  static String? requirePermission(
    BuildContext context,
    GoRouterState state, {
    required bool Function(UserModel user) hasPermission,
  }) {
    final authState = _authState(context);
    if (authState is! Authenticated) return _loginLocation(state);
    if (hasPermission(authState.user)) return null;
    return UnauthorizedRoute(attemptedPath: state.uri.toString()).location;
  }

  static String _loginLocation(GoRouterState state) =>
      LoginRoute(from: state.uri.toString()).location;

  static AuthState _authState(BuildContext context) =>
      ProviderScope.containerOf(context).read(authViewModelProvider);
}
