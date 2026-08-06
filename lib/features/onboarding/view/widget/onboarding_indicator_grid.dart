part of '../onboarding_view.dart';

final class OnboardingIndicatorGrid extends ConsumerWidget {
  const OnboardingIndicatorGrid({super.key});

  static const _containerHeightRatio = 0.24;
  static const _centerRatio = 0.32;
  static const _normalOffsetRatio = 0.25;
  static const _selectedOffsetRatio = 0.30;
  static const _turnStep = 0.25;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingViewModelProvider);
    final activeFeatureIndex = state.step;
    final turns = _calculateTurns(activeFeatureIndex);

    final containerSize = context.sized.dynamicHeight(_containerHeightRatio);
    final center = containerSize * _centerRatio;
    final normalOffset = containerSize * _normalOffsetRatio;
    final selectedOffset = containerSize * _selectedOffsetRatio;

    const features = OnboardingStep.pages;
    final angleStep = (2 * math.pi) / features.length;

    return AnimatedRotation(
      turns: turns,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Center(
        child: SizedBox(
          width: containerSize,
          height: containerSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(features.length, (index) {
              final isSelected = activeFeatureIndex == index;
              final offset = isSelected ? selectedOffset : normalOffset;

              final angle = (math.pi / 2) - (index * angleStep);
              final dx = math.cos(angle).roundToDouble();
              final dy = math.sin(angle).roundToDouble();

              return AnimatedPositioned(
                key: ValueKey(features[index].category),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                top: center + (dy * offset),
                left: center + (dx * offset),
                child: _OnboardingIconBox(
                  model: features[index],
                  isSelected: isSelected,
                  turns: turns,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  double _calculateTurns(int featureIndex) {
    if (featureIndex <= 0) return 0;
    return featureIndex * _turnStep;
  }
}

final class _OnboardingIconBox extends StatelessWidget {
  const _OnboardingIconBox({
    required this.model,
    required this.isSelected,
    required this.turns,
  });

  final OnboardingStep model;
  final bool isSelected;
  final double turns;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      scale: isSelected ? 1.0 : 0.85,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: AnimatedContainer(
          duration: Duration(milliseconds: isSelected ? 350 : 120),
          curve: isSelected ? Curves.easeOutCubic : Curves.easeIn,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isSelected
                ? model.color
                : context.appColors.navy100.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: model.color.withValues(alpha: 0.55),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: AnimatedRotation(
              turns: -turns,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: Icon(
                model.icon,
                size: AppIconSizes.largeX,
                color: isSelected
                    ? context.appColors.white
                    : context.appColors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
