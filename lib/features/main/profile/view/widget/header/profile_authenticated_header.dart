import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/main/profile/view/widget/header/profile_statics.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';

final class ProfileAuthenticatedHeader extends ConsumerWidget {
  const ProfileAuthenticatedHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider).user;
    if (user == null) return const SizedBox.shrink();

    final favoriteCount = ref.watch(
      ProjectDependencyItems.productProviderState.select(
        (state) => state.favoritePlaces.length,
      ),
    );
    final avatarRadius = context.sized.dynamicWidth(.1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Row(
          spacing: AppSpacing.sm,
          children: [
            CustomUserAvatar(
              userName: user.displayName,
              imageUrl: user.photoUrl,
              radius: avatarRadius,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxs,
                children: [
                  Text(
                    user.displayName,
                    style: AppText.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy800,
                    ),
                  ),
                  Row(
                    children: [
                      // TODO(profile): Paylaşım alanı değişecek ve yönlendirmesi eklenecek.
                      ProfileStatics(
                        count: 10,
                        label: 'Paylaşım',
                        onTap: () {},
                      ),
                      ProfileStatics(
                        count: favoriteCount,
                        label: LocaleKeys.profile_stats_favorites.tr(),
                        onTap: () => const FavoriteRoute().push<void>(context),
                      ),
                      // TODO(profile): Yorum yönlendirmesi eklenecek.
                      ProfileStatics(
                        count: user.rates.length,
                        label: LocaleKeys.profile_stats_comments.tr(),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => const EditProfileRoute().go(context),
            child: Text(LocaleKeys.auth_editProfile_title.tr()),
          ),
        ),
      ],
    );
  }
}
