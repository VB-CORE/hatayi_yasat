import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

/// TODO: Düzenlenmeli
/// Changing location dialog widget with animations
final class ChangingDialog extends StatefulWidget {
  const ChangingDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) => const ChangingDialog(),
    );
  }

  @override
  State<ChangingDialog> createState() => _ChangingDialogState();
}

class _ChangingDialogState extends State<ChangingDialog>
    with TickerProviderStateMixin {
  late final AnimationController _dialogAnimationController;
  late final AnimationController _iconAnimationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Dialog Animation (Scale effect)
    _dialogAnimationController = AnimationController(
      vsync: this,
      duration: DurationConstant.durationLong,
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(
        parent: _dialogAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Icon Animation (Scale and Rotation)
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: ColorsCustom.white,
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.large,
        ),
        title: AnimatedBuilder(
          animation: _iconAnimationController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + _iconAnimationController.value * .3,
              child: Transform.rotate(
                angle: _rotateAnimation.value,
                child: Padding(
                  padding: const PagePadding.generalAllNormal(),
                  child: Assets.icons.icApp.image(
                    height: WidgetSizes.spacingXxl12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dialogAnimationController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }
}
