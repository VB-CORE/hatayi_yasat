import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/splash/splash_view_mixin.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

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
    return Scaffold(
      body: Padding(
        padding: const PagePadding.horizontal16Symmetric(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.sized.dynamicHeight(.3),
                child: Assets.lottie.cityLoadingBetter.lottie(
                  controller: lottieController,
                  onLoaded: onLoadedLottie,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const PagePadding.onlyLeft10(),
                    child: Text(
                      LocaleKeys.project_name,
                      style: context.general.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorCommon(context).whiteAndBlackForTheme,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                  ),
                  Padding(
                    padding: const PagePadding.onlyLeft() +
                        const PagePadding.onlyTop(),
                    child: const SizedBox.square(
                      dimension: WidgetSizes.spacingXxl2,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
