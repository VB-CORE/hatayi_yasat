import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';
import 'package:vbaseproject/features/splash/view_model/splash_view_model.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/onboard_router/onboard_router.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/not_connected_to_internet_dialog.dart';

mixin SplashViewMixin
    on AppProviderMixin<SplashView>, ConsumerState<SplashView> {
  late final StateNotifierProvider<SplashViewModel, SplashState> _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = StateNotifierProvider(
      (ref) => SplashViewModel(
        appProvider: appProvider,
        productProvider: productProvider,
      ),
    );

    ref.listenManual(_homeProvider, (previous, next) async {
      if (next.isNeedToOnBoard) {
        const OnboardRoute().pushReplacement(context);
        // await HomeDetailRoute().push(context);
        // HomeDetailRoute($extra: PlaceRequestModel.dummyData);
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
