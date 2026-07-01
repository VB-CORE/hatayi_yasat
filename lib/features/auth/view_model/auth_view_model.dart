import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
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
      onError: (_) => state = const AuthError('auth_error'),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    final user = await authService.signInWithGoogle();
    state = user == null
        ? const AuthError('google_sign_in_failed')
        : Authenticated(user);
  }

  // TODO(auth): Gerçek backend rol desteği gelince bu metodu kaldır.
  void debugSignInAs(UserRole role) {
    if (!kDebugMode) return;
    _logger.d('debugSignInAs called with role: ${role.name}');
    state = Authenticated(
      AppUser(
        uid: 'debug-${role.name}',
        email: '${role.name}@debug.com',
        displayName: 'Debug ${role.name}',
        role: role,
      ),
    );
  }
}
