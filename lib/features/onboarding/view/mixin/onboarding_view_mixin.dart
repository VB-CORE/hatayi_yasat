import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/onboarding/view/onboarding_view.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin OnboardingViewMixin
    on AppProviderMixin<OnboardingView>, ConsumerState<OnboardingView> {
  late final OnboardingViewModelProvider _onboardingProvider;

  Future<void> onNextPressed() async {
    final state = ref.read(_onboardingProvider);
    if (state.isLastPage) {
      await _completeOnboarding();
    } else {
      ref.read(_onboardingProvider.notifier).next();
    }
  }

  Future<void> onSkipPressed() async {
    await _completeOnboarding();
  }

  void onBackPressed() {
    ref.read(_onboardingProvider.notifier).previous();
  }

  Future<void> _completeOnboarding() async {
    await SharedCache.instance.setCompleteOnboarding();
    if (!mounted) return;
    const LoginRoute().go(context);
  }
}
