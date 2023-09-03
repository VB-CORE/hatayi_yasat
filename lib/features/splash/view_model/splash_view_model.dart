import 'package:riverpod/riverpod.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';

import 'package:vbaseproject/product/model/constant/project_general_constant.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

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
    await productProvider.fetchDistrictAndSaveSession();
    state = state.copyWith(isOperationStaring: false);
  }
}
