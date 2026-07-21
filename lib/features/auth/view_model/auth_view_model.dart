import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
  @override
  AuthState build() {
    final subscription = authService.userStream.listen(
      (user) {
        state = user == null ? const Unauthenticated() : Authenticated(user);
      },
      onError: (Object error, StackTrace stackTrace) =>
          CustomLogger.showError<void>(error),
    );
    ref.onDispose(subscription.cancel);

    final cached = authService.cachedUser;
    return cached == null ? const AuthInitial() : Authenticated(cached);
  }

  Future<void> signIn(AuthProvider provider) async {
    state = const AuthLoading();
    final result = await authService.signIn(provider);
    state = switch (result) {
      SignInSuccess(:final user) => Authenticated(user),
      SignInCancelled() => const Unauthenticated(),
      SignInFailure() => AuthError(
        LocaleKeys.auth_error_failed,
        provider: provider,
      ),
    };
  }

  Future<void> signOut() => authService.signOut();
}
