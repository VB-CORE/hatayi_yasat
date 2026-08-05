import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';
import 'package:lifeclient/features/onboarding/view/mixin/onboarding_view_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView>
    with AppProviderMixin<OnboardingView>, OnboardingViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      body: Stack(
        children: [
          MosaicBackground(
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
                  onPressed: onSkipPressed,
                  child: Text(
                    'Atla',
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
                child: const _WelcomeContent(),
              ),
            ),
          ),
          Positioned(
            top: context.sized.dynamicHeight(.15),
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: state.isWelcomePage ? 0 : 1.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Column(
                children: [
                  // Üstteki kare
                  _buildIconBox(context),

                  // Orta satır (Sol ve Sağ kareler)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconBox(context),
                      // İki kare arasındaki boşluk. Tam 45 derece dönmüş bir grid
                      // görüntüsü için burayı bir kutunun genişliği kadar ayarlayabilirsin.
                      const SizedBox(width: 80),
                      _buildIconBox(context),
                    ],
                  ),

                  // Alttaki kare
                  _buildIconBox(context),
                ],
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
                        : _OnboardingCardContent(
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
            child: SizedBox(
              width: double.infinity,
              child: GeneralButtonV2.active(
                action: onNextPressed,
                label: state.isWelcomePage
                    ? 'Başlayalım'
                    : (state.isLastPage ? 'Tamamla' : 'Devam Et'),
                icon: AppIcons.arrowForward,
                iconAlignment: IconAlignment.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4, // 45 derece (pi / 4 radyandır)
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.appColors.navy100.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: context.appColors.white.withValues(alpha: 0.5),
          ),
        ),
        // Bu Transform, kutu döndükten sonra içindeki simgeyi tersine
        // döndürerek onun düz (dik) durmasını sağlar.
        child: Transform.rotate(
          angle: -math.pi / 4, // Simgeyi dik tutmak için ters döndürme
          child: Icon(
            Icons.home,
            color: context.appColors.white,
            size: AppIconSizes.largeX,
          ),
        ),
      ),
    );
  }
}

class _WelcomeContent extends StatelessWidget {
  const _WelcomeContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        spacing: WidgetSizes.spacingL,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            child: CustomShimmer(
              duration: const Duration(seconds: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appColors.navy700.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Assets.icons.icAppTransparent.image(
                    height: context.sized.dynamicWidth(.25),
                  ),
                ),
              ),
            ),
          ),
          Text(
            LocaleKeys.project_name.tr(),
            style: AppText.displayLg.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.navy100,
            ),
          ),
          SizedBox(
            width: context.sized.dynamicWidth(.75),
            child: Text(
              "Şehrin esnafı, topluluğu ve hafızası tek uygulamada. Yeniden ayağa kalkan Hatay'ı birlikte yaşatalım.",
              style: AppText.bodyLg.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appColors.ink300,
              ),
            ),
          ),
          SizedBox(
            height: context.sized.dynamicHeight(.12),
          ),
        ],
      ),
    );
  }
}

class _OnboardingCardContent extends StatelessWidget {
  const _OnboardingCardContent({
    required this.model,
    super.key,
  });

  final OnboardingModel? model;

  @override
  Widget build(BuildContext context) {
    if (model == null) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: WidgetSizes.spacingL,
      children: [
        Text(
          model!.category,
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: model!.color,
          ),
        ),
        Text(
          model!.title,
          style: AppText.displayLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.navy,
          ),
        ),
        Text(
          model!.desc,
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.ink500,
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            chipTheme: ChipThemeData(
              labelStyle: AppText.body.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appColors.navy500,
              ),
              backgroundColor: context.appColors.ink25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
          child: Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: model!.chips
                .map((chipText) => Chip(label: Text(chipText)))
                .toList(),
          ),
        ),
      ],
    );
  }
}
