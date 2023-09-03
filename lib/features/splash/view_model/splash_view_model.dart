import 'package:riverpod/riverpod.dart';
import 'package:vbaseproject/features/splash/view_model/splash_state.dart';

import 'package:vbaseproject/product/model/constant/project_general_constant.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel() : super(const SplashState(isOperationStaring: true)) {
    _controlApplication();
  }

  Future<void> _controlApplication() async {
    await Future.delayed(ProjectGeneralConstant.durationVeryHigh);
    state = state.copyWith(isOperationStaring: false);
  }
}
