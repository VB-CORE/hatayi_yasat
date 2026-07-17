import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/auth/firebase_auth_service.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user_model.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
  final AuthService authService = FirebaseAuthService();

  @override
  AuthState build() {
    final subscription = authService.userStream.listen(
      _onUserChanged,
      onError: _onUserStreamError,
    );
    ref.onDispose(subscription.cancel);
    return const AuthInitial();
  }

  void _onUserChanged(AppUser? user) {
    state = user == null ? const Unauthenticated() : Authenticated(user);
  }

  // Sign-out sonrası eski dinleyicinin permission-denied hatası çıkış sayılır.
  void _onUserStreamError(Object error, StackTrace stackTrace) {
    state = authService.isSignedIn
        ? const AuthError(LocaleKeys.auth_error_generic)
        : const Unauthenticated();
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    final user = await authService.signInWithGoogle();
    if (user == null) {
      state = const AuthError(
        LocaleKeys.auth_error_failed,
        provider: AuthProvider.google,
      );
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}
