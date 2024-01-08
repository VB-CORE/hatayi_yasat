import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';
import 'package:vbaseproject/features/splash/view_model/splash_view_model.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/onboard_router/onboard_router.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/navigation/project_navigation.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/bottom_sheet/firebase_error_bottom_sheet.dart';
import 'package:vbaseproject/product/widget/dialog/not_connected_to_internet_dialog.dart';

mixin SplashViewMixin
    on
        AppProviderMixin<SplashView>,
        ConsumerState<SplashView>,
        SingleTickerProviderStateMixin<SplashView> {
  late final StateNotifierProvider<SplashViewModel, SplashState> _homeProvider;
  final bool _hasFirebaseError = false;

  late final AnimationController _controller;
  AnimationController get lottieController => _controller;

  void onLoadedLottie(LottieComposition composition) {
    _controller
      ..duration = composition.duration
      ..repeat(min: 0.6, max: 1);
  }

  @override
  void dispose() {
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
      if (next.isNeedToForceUpdate) {
        return;
      }
      if (_hasFirebaseError) {
        await FirebaseErrorBottomSheet.show(context);
        return;
      }
      if (next.isNeedToOnBoard) {
        ProjectNavigation(context).replaceToWidget(const OnBoardView());
        return;
      }
      if (!next.isOperationStaring) {
        const MainTabRoute().go(context);
      }
    });
  }
}
