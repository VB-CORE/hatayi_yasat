import 'package:riverpod/riverpod.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/package/checker/network_checker.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/utility/validator/version_validator.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel({required this.productProvider, required this.appProvider})
      : super(const SplashState(isOperationStaring: true)) {
    _controlApplication();
  }
  final ProductProvider productProvider;
  final AppProvider appProvider;

  Future<void> _controlApplication() async {
    await appProvider.init();

    if (!await _isConnectedToInternet()) {
      state = state.copyWith(isConnectedToInternet: false);
      return;
    }

    if (_isFirstTimeCheck()) {
      await SharedCache.instance.setFirstAppOpen();
      state = state.copyWith(isNeedToOnBoard: true);
      return;
    }
    if (_isNeedToForceUpdate()) {
      state = state.copyWith(isNeedToForceUpdate: true);
      return;
    }

    await Future.wait([
      productProvider.fetchDistrictAndSaveSession(),
      productProvider.fetchDevelopersAndAgency(),
      productProvider.fetchCategories(),
    ]);
    state = state.copyWith(isOperationStaring: false);
  }

  bool _isFirstTimeCheck() => SharedCache.instance.isFirstAppOpen;

  bool _isNeedToForceUpdate() => VersionValidator.check();

  Future<bool> _isConnectedToInternet() => NetworkChecker.checkConnection();

  Future<void> refresh() async {
    state = const SplashState(isOperationStaring: true);
    await _controlApplication();
  }
}
