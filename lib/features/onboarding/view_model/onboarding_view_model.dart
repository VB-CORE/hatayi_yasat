import 'package:lifeclient/features/onboarding/models/onboarding_step.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_view_model.g.dart';

@riverpod
final class OnboardingViewModel extends _$OnboardingViewModel {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  void next() {
    if (!state.isLast) {
      state = state.copyWith(pageIndex: state.pageIndex + 1);
    }
  }

  void previous() {
    if (!state.isWelcome) {
      state = state.copyWith(pageIndex: state.pageIndex - 1);
    }
  }

  void skip() {
    state = state.copyWith(pageIndex: OnboardingStep.pages.length);
  }
}
