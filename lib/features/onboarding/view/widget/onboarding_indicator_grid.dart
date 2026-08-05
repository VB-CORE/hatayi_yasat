import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';

final class OnboardingIndicatorGrid extends ConsumerWidget {
  const OnboardingIndicatorGrid({super.key});

  static const _size = 200.0;
  static const _center = 64.0;
  static const _selectedOffset = 60.0;
  static const _normalOffset = 50.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingViewModelProvider);

    final currentIndex = state.currentIndex;
    final turns = _groupTurns(currentIndex);

    return AnimatedRotation(
      turns: turns,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Center(
        child: SizedBox(
          width: _size,
          height: _size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (final index in const [3, 4, 2, 1])
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  top: _top(index, currentIndex),
                  left: _left(index, currentIndex),
                  child: _OnboardingIconBox(
                    boxIndex: index,
                    currentIndex: currentIndex,
                    turns: turns,
                    model: state.onboardingList[index - 1],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static double _groupTurns(int currentIndex) =>
      currentIndex <= 1 ? 0 : (currentIndex - 1) * .25;

  static double _top(int boxIndex, int currentIndex) => switch (boxIndex) {
    3 => _center - _offset(currentIndex, boxIndex),
    1 => _center + _offset(currentIndex, boxIndex),
    _ => _center,
  };

  static double _left(int boxIndex, int currentIndex) => switch (boxIndex) {
    4 => _center - _offset(currentIndex, boxIndex),
    2 => _center + _offset(currentIndex, boxIndex),
    _ => _center,
  };

  static double _offset(int currentIndex, int boxIndex) =>
      currentIndex == boxIndex ? _selectedOffset : _normalOffset;
}

final class _OnboardingIconBox extends StatelessWidget {
  const _OnboardingIconBox({
    required this.boxIndex,
    required this.currentIndex,
    required this.turns,
    required this.model,
  });

  final int boxIndex;
  final int currentIndex;
  final double turns;
  final OnboardingModel model;

  bool get isSelected => currentIndex == boxIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      scale: isSelected ? 1 : .85,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: AnimatedContainer(
          duration: Duration(milliseconds: isSelected ? 350 : 120),
          curve: isSelected ? Curves.easeOutCubic : Curves.easeIn,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isSelected
                ? model.color
                : context.appColors.navy100.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              BoxShadow(
                color: model.color.withValues(alpha: isSelected ? .55 : 0),
                blurRadius: isSelected ? 20 : 0,
                offset: Offset(0, isSelected ? 8 : 0),
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
                    : context.appColors.white.withValues(alpha: .5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
