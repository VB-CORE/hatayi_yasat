import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';

final class OnboardingState extends Equatable {
  const OnboardingState({
    this.currentIndex = 0,
    this.onboardingList = const [],
  });

  final int currentIndex;

  final List<OnboardingModel> onboardingList;

  bool get isWelcomePage => currentIndex == 0;

  bool get isLastPage => currentIndex == onboardingList.length;

  OnboardingModel? get currentModel {
    if (isWelcomePage || currentIndex > onboardingList.length) return null;
    return onboardingList[currentIndex - 1];
  }

  @override
  List<Object?> get props => [currentIndex, onboardingList];

  OnboardingState copyWith({
    int? currentIndex,
    List<OnboardingModel>? onboardingList,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      onboardingList: onboardingList ?? this.onboardingList,
    );
  }
}
