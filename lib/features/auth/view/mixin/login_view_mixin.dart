import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin LoginViewMixin on ConsumerState<LoginView>, AppProviderMixin<LoginView> {
  @override
  void initState() {
    super.initState();
    ref.listenManual<AuthState>(authViewModelProvider, (previous, next) {
      if (next is! AuthError) return;
      final provider = next.provider;
      final message = provider == null
          ? next.message.tr()
          : next.message.tr(
              namedArgs: {AuthProvider.argKey: provider.displayName},
            );
      appProvider.showSnackbarMessage(message);
    });
  }

  Future<void> onGoogleSignIn() => ref
      .read(authViewModelProvider.notifier)
      .signIn(AuthProvider.google);

  void onGuestTap() => const MainTabRoute().go(context);
}
