import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin LoginViewMixin on ConsumerState<LoginView>, AppProviderMixin<LoginView> {
  Future<void> onGoogleSignIn() async {
    await ref.read(authViewModelProvider.notifier).signInWithGoogle();
    if (!mounted) return;
    final state = ref.read(authViewModelProvider);
    if (state is AuthError) {
      appProvider.showSnackbarMessage(state.message.tr());
    }
  }

  void onGuestTap() => const MainTabRoute().go(context);

  bool get isLoading => ref.watch(authViewModelProvider) is AuthLoading;
}
