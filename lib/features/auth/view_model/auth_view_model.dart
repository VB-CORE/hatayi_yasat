import 'dart:async';

import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
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
}
