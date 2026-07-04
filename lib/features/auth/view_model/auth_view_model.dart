import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/auth/mock_auth_service.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
  final Logger _logger = Logger();

  StreamSubscription<AppUser?>? _authSubscription;

  @override
  AuthState build() {
    ref.onDispose(() => _authSubscription?.cancel());
    _listenAuth();
    return const AuthInitial();
  }

  void _listenAuth() {
    _authSubscription = authService.userStream.listen(
      (user) {
        state = user == null ? const Unauthenticated() : Authenticated(user);
      },
      onError: (_) => state = const AuthError(LocaleKeys.auth_error_generic),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    final user = await authService.signInWithGoogle();
    state = user == null
        ? const AuthError(
            LocaleKeys.auth_error_failed,
            provider: AuthProvider.google,
          )
        : Authenticated(user);
  }

  Future<void> signOut() async {
    await authService.signOut();
    state = const Unauthenticated();
  }

  // TODO(auth): Gerçek backend rol desteği gelince bu metodu kaldır.
  Future<void> debugSignInAs(UserRole role) async {
    if (!kDebugMode) return;
    _logger.d('debugSignInAs called with role: ${role.name}');
    final user = await MockAuthService().signInAsRole(role);
    state = Authenticated(user);
  }
}
