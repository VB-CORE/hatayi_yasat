import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';

final class AuthSwitcher extends ConsumerWidget {
  const AuthSwitcher({
    required this.authorized,
    this.unauthorized = const SizedBox.shrink(),
    super.key,
  });

  final Widget authorized;
  final Widget unauthorized;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(
      authViewModelProvider.select((state) => state.isAuthenticated),
    );
    return isAuthenticated ? authorized : unauthorized;
  }
}
