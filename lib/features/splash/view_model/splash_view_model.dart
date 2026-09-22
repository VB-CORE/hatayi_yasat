import 'dart:async';

import 'package:lifeclient/features/splash/view_model/splash_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/package/checker/network_checker.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';
import 'package:lifeclient/product/utility/validator/version_validator.dart';
import 'package:riverpod/riverpod.dart';

class SplashViewModel extends Notifier<SplashState> {
  SplashViewModel({required this.productProvider});
  final ProductProvider productProvider;

  Future<void> _controlApplication() async {
    if (!await _isConnectedToInternet()) {
      state = state.copyWith(isConnectedToInternet: false);
      return;
    }

    final isInitialized = await productProvider.initWhenApplicationStart();
    if (!isInitialized) {
      state = state.copyWith(isError: true);
      return;
    }

    if (!_isCompletedOnboardingCheck()) {
      state = state.copyWith(isNeedToOnBoard: true);
      return;
    }
    if (await _isNeedToForceUpdate()) {
      state = state.copyWith(isNeedToForceUpdate: true);
      return;
    }

    state = state.copyWith(isOperationStaring: false);
  }

  bool _isCompletedOnboardingCheck() =>
      SharedCache.instance.isCompletedOnboarding;

  Future<bool> _isNeedToForceUpdate() => VersionValidator.check();

  Future<bool> _isConnectedToInternet() => NetworkChecker.checkConnection();

  Future<void> refresh() async {
    state = const SplashState(isOperationStaring: true);
    await _controlApplication();
  }

  @override
  SplashState build() {
    unawaited(_controlApplication());
    return const SplashState(isOperationStaring: true);
  }
}
