import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';

final class ProfileTabAvatar extends ConsumerWidget {
  const ProfileTabAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider).user;

    if (user == null) return const HugeIcon(icon: HugeIcons.strokeRoundedUser);

    return CustomUserAvatar(
      userName: user.displayName,
      imageUrl: user.photoUrl,
    );
  }
}
