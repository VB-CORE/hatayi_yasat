import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/onboarding/models/onboarding_step.dart';

final class OnboardingState extends Equatable {
  const OnboardingState({this.pageIndex = 0});

  final int pageIndex;

  bool get isWelcome => pageIndex == 0;

  int get step => pageIndex - 1;

  bool get isLast => pageIndex == OnboardingStep.pages.length;

  OnboardingStep? get currentStep =>
      isWelcome ? null : OnboardingStep.pages[step];

  @override
  List<Object?> get props => [pageIndex];

  OnboardingState copyWith({int? pageIndex}) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
