import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/onboarding/view/onboarding_view.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin OnboardingViewMixin
    on AppProviderMixin<OnboardingView>, ConsumerState<OnboardingView> {
  Future<void> onNext() async {
    final state = ref.read(onboardingViewModelProvider);
    if (state.isLastPage) {
      await _completeOnboarding();
    } else {
      ref.read(onboardingViewModelProvider.notifier).next();
    }
  }

  Future<void> onSkip() async {
    await _completeOnboarding();
  }

  void onBack() {
    ref.read(onboardingViewModelProvider.notifier).previous();
  }

  Future<void> _completeOnboarding() async {
    await SharedCache.instance.setCompleteOnboarding();
    if (!mounted) return;
    const LoginRoute().go(context);
  }
}
