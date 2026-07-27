import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/model/enum/hero_tags.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/shadow/general_shadow.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

final class QrFabButton extends StatelessWidget {
  const QrFabButton({required this.bottom, super.key});

  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: WidgetSizes.spacingM,
      bottom: bottom + WidgetSizes.spacingM,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.white, AppColors.teal300],
          ),
          boxShadow: [GeneralShadow.sampleGrayShadow(color: AppColors.teal100)],
        ),
        child: CustomShimmer(
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () => const UserQrRoute().go(context),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            child: Hero(
              tag: HeroTags.userQrFab.name,
              child: Assets.icons.icAppTransparent.image(
                width: AppIconSizes.largeX,
                height: AppIconSizes.largeX,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
