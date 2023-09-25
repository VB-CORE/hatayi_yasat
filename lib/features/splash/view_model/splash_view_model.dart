import 'package:riverpod/riverpod.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/model/constant/project_general_constant.dart';
import 'package:vbaseproject/product/utility/checker/network_checker.dart';
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
    await Future.delayed(ProjectGeneralConstant.durationVeryHigh, () {});
    await appProvider.init();

    if (_isFirstTimeCheck()) {
      await SharedCache.instance.setFirstAppOpen();
      state = state.copyWith(isNeedToOnBoard: true);
      return;
    }
    if (_isNeedToForceUpdate()) {
      state = state.copyWith(isNeedToForceUpdate: true);
      return;
    }

    if (await _isConnectedToInternet()) {
      state = state.copyWith(isConnectedToInternet: true);
    }

    await productProvider.fetchDistrictAndSaveSession();
    await productProvider.fetchDevelopersAndAgency();
    await productProvider.fetchCategories();
    state = state.copyWith(isOperationStaring: false);
  }

  bool _isFirstTimeCheck() {
    return SharedCache.instance.isFirstAppOpen();
  }

  bool _isNeedToForceUpdate() {
    return VersionValidator.check();
  }

  Future<bool> _isConnectedToInternet() {
    return NetworkChecker.checkConnection();
  }

  Future<void> refresh() async {
    await _controlApplication();
  }
}
