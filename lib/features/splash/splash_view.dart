import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/features/onboarding/view/onboarding_view.dart';
import 'package:lifeclient/features/splash/splash_view_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
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
            MosaicBackground(
              animate: true,
              tileSize: AppIconSizes.large,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.appColors.navy500,
                  context.appColors.navy900,
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeHeader(crossAxisAlignment: .center),
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
