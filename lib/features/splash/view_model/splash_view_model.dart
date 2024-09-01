import 'package:lifeclient/features/splash/view_model/splash_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/package/checker/network_checker.dart';
import 'package:lifeclient/product/utility/state/app_provider.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';
import 'package:lifeclient/product/utility/validator/version_validator.dart';
import 'package:riverpod/riverpod.dart';

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

    await productProvider.initWhenApplicationStart();

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
