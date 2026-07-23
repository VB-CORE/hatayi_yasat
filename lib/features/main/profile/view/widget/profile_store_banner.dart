import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';

final class ProfileStoreBanner extends ConsumerWidget {
  const ProfileStoreBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomBounceable(
      onTap: () {
        final isAuthenticated = ref.read(authViewModelProvider).isAuthenticated;
        if (!isAuthenticated) {
          const LoginRoute().go(context);
          return;
        }
        const PlaceRequestFormRoute().go(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: .circular(AppRadius.md),
          border: .all(color: AppColors.coral400),
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.sm,
            children: [
              SizedBox(
                width: context.sized.dynamicWidth(0.16),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    MosaicBackground(),
                    Icon(
                      AppIcons.store,
                      size: AppIconSizes.largeX,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: .circular(AppRadius.sm),
                  ),
                  padding: const PagePadding.vertical12Symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppSpacing.xxs,
                    children: [
                      Text(
                        LocaleKeys.profile_storeBanner_title.tr(),
                        style: AppText.title.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        LocaleKeys.profile_storeBanner_subtitle.tr(),
                        style: AppText.body.copyWith(
                          color: AppColors.ink500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
