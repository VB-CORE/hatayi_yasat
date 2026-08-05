import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/onboarding/view/onboarding_view.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin OnboardingViewMixin
    on AppProviderMixin<OnboardingView>, ConsumerState<OnboardingView> {
  late final OnboardingViewModelProvider _onboardingProvider;

  OnboardingViewModelProvider get onboardingProvider => _onboardingProvider;

  @override
  void initState() {
    super.initState();
    _onboardingProvider = onboardingViewModelProvider;
  }

  void onNextPressed() {
    final state = ref.read(_onboardingProvider);
    if (state.isLastPage) {
      _completeOnboarding();
    } else {
      ref.read(_onboardingProvider.notifier).next();
    }
  }

  void onSkipPressed() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    if (!mounted) return;
    const LoginRoute().go(context);
  }
}
