import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/auth_guard.dart';
import 'package:lifeclient/product/navigation/router_notifier.dart';

final class _FakeAuthService implements AuthService {
  final StreamController<UserModel?> _controller =
      StreamController<UserModel?>.broadcast();

  @override
  Stream<UserModel?> get userStream => _controller.stream;

  @override
  UserModel? get cachedUser => null;

  @override
  Future<SignInResult> signIn(AuthProvider provider) async =>
      const SignInCancelled();

  @override
  Future<void> signOut() async {}

  void emit(UserModel? user) => _controller.add(user);
}

/// The real one reaches for `FirebaseAnalytics.instance` in its constructor,
/// which needs a live Firebase app the test binding has no way to provide.
final class _FakeAnalyticsService implements AnalyticsService {
  @override
  void logEvent(
    AnalyticsEvent event, {
    Map<AnalyticsParameter, Object?> parameters = const {},
  }) {}

  @override
  void logScreenView(String screenName) {}

  @override
  void setUser(UserModel? user, {required AnalyticsAuthStatus status}) {}

  @override
  void setUserProperty(AnalyticsUserProperty property, String? value) {}

  @override
  void recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  }) {}

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {}
}

/// Same reason as [_FakeAnalyticsService]: the real one reaches for
/// `FirebaseAuth.instance` while being constructed.
final class _FakeUserService implements UserService {
  @override
  Future<bool> update({String? displayName, int? avatarType}) async => true;

  @override
  Future<bool> stepCounter(UserCounterFields counter, {int by = 1}) async =>
      true;
}

void main() {
  late _FakeAuthService fakeAuth;

  setUpAll(() {
    ProjectDependency.setup();
    fakeAuth = _FakeAuthService();
    // ProjectDependencyMixin resolves every service the moment a ViewModel is
    // constructed, so each Firebase-backed one has to be swapped out — not
    // just the auth service under test.
    GetIt.I
      ..unregister<AnalyticsService>()
      ..registerSingleton<AnalyticsService>(_FakeAnalyticsService())
      ..unregister<UserService>()
      ..registerSingleton<UserService>(_FakeUserService())
      ..unregister<AuthService>()
      ..registerSingleton<AuthService>(fakeAuth);
  });

  testWidgets('auth emission bounces login route via refreshListenable', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: '/login?from=/target',
      refreshListenable: container.read(routerNotifierProvider),
      routes: [
        GoRoute(
          path: '/login',
          redirect: (context, state) => AuthGuard.redirectIfSignedIn(
            context,
            state,
            to: state.uri.queryParameters['from'],
          ),
          builder: (_, _) => const Text('login'),
        ),
        GoRoute(path: '/main', builder: (_, _) => const Text('main')),
        GoRoute(path: '/target', builder: (_, _) => const Text('target')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('login'), findsOneWidget);

    fakeAuth.emit(const UserModel(uid: 'u1', email: 'u@x.com'));
    await tester.pumpAndSettle();

    expect(find.text('target'), findsOneWidget);
  });

  testWidgets('generated LoginRoute bounces on auth emission', (tester) async {
    tester.view.physicalSize = const Size(1440, 3040);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: const LoginRoute(from: '/unauthorized').location,
      refreshListenable: container.read(routerNotifierProvider),
      routes: $appRoutes,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      '/login',
    );

    fakeAuth.emit(const UserModel(uid: 'u1', email: 'u@x.com'));
    await tester.pump();

    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      '/unauthorized',
    );
  });

  testWidgets('guarded go redirects signed-out user to login with from', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 3040);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: const UnauthorizedRoute().location,
      refreshListenable: container.read(routerNotifierProvider),
      routes: $appRoutes,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    router.go(const ProjectRequestFormRoute().location);
    await tester.pump();
    await tester.pump();

    final uri = router.routerDelegate.currentConfiguration.uri;
    expect(uri.path, '/login');
    expect(
      uri.queryParameters['from'],
      const ProjectRequestFormRoute().location,
    );
    expect(find.byType(LoginView), findsOneWidget);
  });
}
