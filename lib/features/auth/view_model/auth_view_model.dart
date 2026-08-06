import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
final class AuthViewModel extends _$AuthViewModel with ProjectDependencyMixin {
  @override
  AuthState build() {
    final subscription = authService.userStream.listen(
      (user) {
        state = _stateFor(user);
      },
      onError: (Object error, StackTrace stackTrace) =>
          CustomLogger.showError<void>(error),
    );
    ref.onDispose(subscription.cancel);

    final cached = authService.cachedUser;
    return cached == null ? const AuthInitial() : _stateFor(cached);
  }

  AuthState _stateFor(UserModel? user) {
    if (user == null) return const Unauthenticated();
    return user.isBanned ? AuthBanned(user) : Authenticated(user);
  }

  Future<void> signIn(AuthProvider provider) async {
    state = AuthLoading(provider);
    final result = await authService.signIn(provider);
    state = switch (result) {
      SignInSuccess(:final user) => _stateFor(user),
      SignInCancelled() => const Unauthenticated(),
      SignInFailure() => AuthError(
        LocaleKeys.auth_error_failed,
        provider: provider,
      ),
    };
    if (result case SignInSuccess(:final isNewUser)) {
      analyticsService.logEvent(
        isNewUser ? AnalyticsEvent.signUp : AnalyticsEvent.login,
        parameters: {AnalyticsParameter.method: provider.name},
      );
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    analyticsService.logEvent(AnalyticsEvent.logout);
  }

  void updateApplication(UserApplicationModel application) {
    final user = state.user;
    if (user == null) return;
    final updatedUser = user.copyWith(application: application);
    productCache.userCache.update(updatedUser);
    state = _stateFor(updatedUser);
  }
}
