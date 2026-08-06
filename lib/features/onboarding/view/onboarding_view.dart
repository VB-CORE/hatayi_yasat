import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/onboarding/view/mixin/onboarding_view_mixin.dart';
import 'package:lifeclient/features/onboarding/view/widget/onboarding_card_content.dart';
import 'package:lifeclient/features/onboarding/view/widget/onboarding_indicator_grid.dart';
import 'package:lifeclient/features/onboarding/view/widget/onboarding_navigation_row.dart';
import 'package:lifeclient/features/onboarding/view/widget/onboarding_welcome_content.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView>
    with AppProviderMixin<OnboardingView>, OnboardingViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          MosaicBackground(
            tileSize: AppIconSizes.large,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.appColors.navy800,
                context.appColors.navy500,
              ],
            ),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).viewPadding.top + WidgetSizes.spacingM,
            right: const PagePadding.all().right,
            child: AnimatedOpacity(
              opacity: state.isWelcomePage ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: state.isWelcomePage,
                child: TextButton(
                  onPressed: onSkip,
                  child: Text(
                    LocaleKeys.onboarding_button_skip.tr(),
                    style: AppText.bodyLg.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: AnimatedOpacity(
              opacity: state.isWelcomePage ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: !state.isWelcomePage,
                child: const OnboardingWelcomeContent(),
              ),
            ),
          ),

          Positioned(
            top: context.sized.dynamicHeight(.15),
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: state.isWelcomePage ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: state.isWelcomePage,
                child: const OnboardingIndicatorGrid(),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSlide(
              offset: state.isWelcomePage ? const Offset(0, 1.2) : Offset.zero,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: Container(
                width: double.infinity,
                padding:
                    const PagePadding.all() +
                    EdgeInsets.only(bottom: context.sized.dynamicHeight(.12)),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.xxl),
                    topRight: Radius.circular(AppRadius.xxl),
                  ),
                  boxShadow: AppShadows.card,
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    layoutBuilder: (currentChild, previousChildren) {
                      return currentChild ?? const SizedBox.shrink();
                    },
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                        child: child,
                      );
                    },
                    child: state.isWelcomePage
                        ? const SizedBox.shrink()
                        : OnboardingCardContent(
                            key: ValueKey(state.currentIndex),
                            model: state.currentModel,
                          ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom:
                MediaQuery.of(context).viewPadding.bottom +
                const PagePadding.all().bottom,
            left: const PagePadding.all().left,
            right: const PagePadding.all().right,
            child: OnboardingNavigationRow(
              state: state,
              onNext: onNext,
              onBack: onBack,
            ),
          ),
        ],
      ),
    );
  }
}
