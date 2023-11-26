import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';
import 'package:vbaseproject/features/splash/view_model/splash_view_model.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/navigation/project_navigation.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/dialog/not_connected_to_internet_dialog.dart';
import 'package:vbaseproject/sub_feature/onboard/on_board_view.dart';

mixin SplashViewMixin
    on AppProviderMixin<SplashView>, ConsumerState<SplashView> {
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
    ref.listenManual(_homeProvider, (previous, next) async {
      if (next.isNeedToOnBoard) {
        ProjectNavigation(context).replaceToWidget(const OnBoarView());
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
        ProjectNavigation(context).replaceToWidget(const FilterSearchView());
      }
    });
  }
}
