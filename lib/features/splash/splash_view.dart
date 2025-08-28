import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/splash/splash_view_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
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
        body: Padding(
          padding: const PagePadding.horizontal16Symmetric(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.icApp.image(
                  height: context.sized.dynamicHeight(.3),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const PagePadding.onlyLeft10(),
                      child: Text(
                        LocaleKeys.project_name.tr().toUpperCase(),
                        style: context.general.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                          const PagePadding.onlyLeft() +
                          const PagePadding.onlyTop(),
                      child: Assets.lottie.loadingGray.lottie(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
