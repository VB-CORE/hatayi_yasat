part of '../login_view.dart';

final class _AppleSignInButtonConsumer extends ConsumerWidget {
  const _AppleSignInButtonConsumer({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      authViewModelProvider.select(
        (state) => state is AuthLoading && state.provider == AuthProvider.apple,
      ),
    );

    return AppleSignInButton(onTap: onTap, isLoading: isLoading);
  }
}
