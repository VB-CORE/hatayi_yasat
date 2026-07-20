import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/auth/firebase_auth_service.dart';
import 'package:lifeclient/core/service/auth/mock_auth_service.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
  final AuthService authService = FirebaseAuthService();

  // TODO(auth): Firestore users/{uid} hazır olup userStream gerçek AppUser
  // dönmeye başlayınca stream burada dinlenip tek doğruluk kaynağı yapılacak;
  // o zaman metodlardaki manuel state atamaları kaldırılacak.
  @override
  AuthState build() {
    final subscription = authService.userStream.listen((_) {});
    ref.onDispose(subscription.cancel);
    return const AuthInitial();
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
    final user = await MockAuthService().signInAsRole(role);
    state = Authenticated(user);
  }
}
