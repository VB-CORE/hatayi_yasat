import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home/view/home_view.dart';
import 'package:vbaseproject/features/splash/view_model/index.dart';

import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/navigation/project_navigation.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

import 'package:vbaseproject/product/utility/state/product_provider.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with AppProviderMixin {
  late final StateNotifierProvider<SplashViewModel, SplashState> _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = StateNotifierProvider(
      (ref) => SplashViewModel(
        appProvider: appProvider,
        productProvider: ref.read(ProductProvider.provider.notifier),
      ),
    );
    ref.listenManual(_homeProvider, (previous, next) {
      if (!next.isOperationStaring) {
        ProjectNavigation(context).replaceToWidget(const HomeView());
      }
    });
  }

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
                child: Assets.lottie.cityLoadingBetter.lottie(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const PagePadding.onlyLeft10(),
                    child: Text(
                      LocaleKeys.project_name,
                      style: context.general.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            context.general.textTheme.displaySmall?.fontSize,
                      ),
                    ).tr(),
                  ),
                  const Padding(
                    padding: PagePadding.onlyTop(),
                    child: CircularProgressIndicator(),
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
