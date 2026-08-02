import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/features/splash/splash_view_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with
        AppProviderMixin,
        SingleTickerProviderStateMixin<SplashView>,
        SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;

    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.splashView,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const MosaicBackground(showGradient: false),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.85,
                  colors: [
                    colorScheme.surface.withValues(alpha: 0.88),
                    colorScheme.surface.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                    child: Assets.icons.icApp.image(
                      height: context.sized.dynamicHeight(.16),
                    ),
                  ),
                  const EmptyBox.middleHeight(),
                  Text(
                    LocaleKeys.project_name.tr(),
                    style: context.general.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const EmptyBox.smallHeight(),
                  Text(
                    LocaleKeys.splash_tagline.tr(),
                    style: context.general.textTheme.titleSmall?.copyWith(
                      color: colorScheme.tertiary,
                      letterSpacing: WidgetSizes.spacingXSSs,
                    ),
                  ),
                  const EmptyBox.largeHeight(),
                  SizedBox(
                    width: context.sized.dynamicWidth(.35),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: LinearProgressIndicator(
                        minHeight: WidgetSizes.spacingXs,
                        backgroundColor: colorScheme.tertiary.withValues(
                          alpha: 0.15,
                        ),
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
