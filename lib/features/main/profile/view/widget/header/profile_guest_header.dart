import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

final class ProfileGuestHeader extends StatelessWidget {
  const ProfileGuestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final logoSize = context.sized.dynamicWidth(0.15);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.sm,
      children: [
        Row(
          spacing: AppSpacing.sm,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: AppShadows.card,
              ),
              child: Assets.icons.icApp.image(
                width: logoSize,
                height: logoSize,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxs,
                children: [
                  Text(
                    LocaleKeys.project_name.tr(),
                    style: AppText.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy800,
                    ),
                  ),
                  Text(
                    LocaleKeys.auth_tagline.tr(),
                    style: AppText.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.coral400,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    LocaleKeys.rate_loginRequiredTitle.tr(),
                    style: AppText.body.copyWith(
                      color: AppColors.ink500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        FilledButton(
          onPressed: () => const LoginRoute().go(context),
          child: Text(LocaleKeys.button_login.tr()),
        ),
      ],
    );
  }
}
