import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/core/dependency/project_dependency.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';
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
  Future<UserModel?> signIn(AuthProvider provider) async => null;

  @override
  Future<void> signOut() async {}

  void emit(UserModel? user) => _controller.add(user);
}

void main() {
  late _FakeAuthService fakeAuth;

  setUpAll(() {
    ProjectDependency.setup();
    GetIt.I.unregister<AuthService>();
    fakeAuth = _FakeAuthService();
    GetIt.I.registerSingleton<AuthService>(fakeAuth);
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
