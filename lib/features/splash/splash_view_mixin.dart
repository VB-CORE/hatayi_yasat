import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:lifeclient/features/splash/splash_view.dart';
import 'package:lifeclient/features/splash/view_model/splash_state.dart';
import 'package:lifeclient/features/splash/view_model/splash_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/onboard_router/onboard_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/not_connected_to_internet_dialog.dart';

mixin SplashViewMixin
    on
        AppProviderMixin<SplashView>,
        ConsumerState<SplashView>,
        SingleTickerProviderStateMixin<SplashView> {
  late final StateNotifierProvider<SplashViewModel, SplashState> _homeProvider;

  late final AnimationController _controller;
  AnimationController get lottieController => _controller;

  void onLoadedLottie(LottieComposition composition) {
    _controller
      ..duration = composition.duration
      ..repeat(min: 0.6, max: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _homeProvider = StateNotifierProvider(
      (ref) => SplashViewModel(
        appProvider: appProvider,
        productProvider: productProvider,
      ),
    );

    ref.listenManual(_homeProvider, (previous, next) async {
      // When init done, stop lottie animation
      _controller.stop();

      if (next.isNeedToOnBoard) {
        const OnboardRoute().pushReplacement(context);
        return;
      }
      if (next.isNeedToForceUpdate) {
        return;
      }

      if (!next.isConnectedToInternet) {
        final response =
            (await NotConnectedToInternetDialog.show(context)) ?? false;
        if (!response) return;
        await ref.read(_homeProvider.notifier).refresh();
        return;
      }
      if (!next.isOperationStaring) {
        const MainTabRoute().go(context);
      }
    });
  }
}
