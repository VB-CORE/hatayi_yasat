import 'package:lifeclient/features/onboarding/model/onboarding_contents.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_view_model.g.dart';

@riverpod
final class OnboardingViewModel extends _$OnboardingViewModel {
  @override
  OnboardingState build() {
    return OnboardingState(
      onboardingList: OnboardingContents.create(),
    );
  }

  void next() {
    if (state.currentIndex < state.onboardingList.length) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previous() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void skip() {
    state = state.copyWith(currentIndex: state.onboardingList.length);
  }
}
