import 'package:flutter/material.dart';
import 'package:vbaseproject/product/model/constant/project_general_constant.dart';

class AnimatedPageSwitch extends StatelessWidget {
  const AnimatedPageSwitch({
    required this.firstChild,
    required this.secondChild,
    required this.crossFadeState,
    super.key,
  });
  final Widget firstChild;
  final Widget secondChild;
  final CrossFadeState crossFadeState;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState: crossFadeState,
      duration: ProjectGeneralConstant.durationLow,
    );
  }
}
