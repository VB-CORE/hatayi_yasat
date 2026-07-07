part of '../login_view.dart';

final class _GoogleSignInButtonConsumer extends ConsumerWidget {
  const _GoogleSignInButtonConsumer({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      authViewModelProvider.select((state) => state is AuthLoading),
    );

    return GoogleSignInButton(
      text: LocaleKeys.auth_signIn_continueWith.tr(
        namedArgs: {AuthProvider.argKey: AuthProvider.google.displayName},
      ),
      onTap: onTap,
      isLoading: isLoading,
    );
  }
}
