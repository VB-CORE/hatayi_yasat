import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin LoginViewMixin on ConsumerState<LoginView>, AppProviderMixin<LoginView> {
  late final bool isAppleSignInAvailable;

  @override
  void initState() {
    super.initState();
    isAppleSignInAvailable = ref
        .read(authViewModelProvider.notifier)
        .supports(AuthProvider.apple);
    unawaited(SharedCache.instance.setLoginSeen());
    ref.listenManual<AuthState>(authViewModelProvider, (previous, next) {
      if (next is! AuthError) return;
      appProvider.showSnackbarMessage(next.localizedMessage);
    });
  }

  Future<void> onGoogleSignIn() =>
      ref.read(authViewModelProvider.notifier).signIn(AuthProvider.google);

  Future<void> onAppleSignIn() =>
      ref.read(authViewModelProvider.notifier).signIn(AuthProvider.apple);

  void onGuestTap() => const MainTabRoute().go(context);
}
