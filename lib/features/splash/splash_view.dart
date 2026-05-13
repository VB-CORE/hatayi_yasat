import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/splash/splash_view_mixin.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/hy_logo.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
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
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.splashView,
      child: Scaffold(
        backgroundColor: ColorsCustom.navy,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned.fill(
              child: MosaicGrid(tileSize: 18, opacity: 0.18),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorsCustom.navy.withValues(alpha: 0),
                    ColorsCustom.navy.withValues(alpha: 0.7),
                    ColorsCustom.navy,
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HyLogo(size: 96),
                  const SizedBox(height: 22),
                  Text(
                    LocaleKeys.project_name.tr(),
                    style: V2Typography.display(
                      fontSize: 36,
                      color: ColorsCustom.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Eyebrow(LocaleKeys.auth_eyebrow.tr()),
                ],
              ),
            ),
            Positioned(
              left: 32,
              right: 32,
              bottom: 60,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: const LinearProgressIndicator(
                      minHeight: 3,
                      backgroundColor: Color(0x33FFFFFF),
                      valueColor: AlwaysStoppedAnimation(ColorsCustom.coral),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.auth_splashLoadingMessage.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: ColorsCustom.white.withValues(alpha: 0.7),
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
