import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/widget/opacity/custom_opacity.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class CustomSpeedDial extends StatelessWidget {
  const CustomSpeedDial({
    required this.children,
    super.key,
  });

  final List<SpeedDialChild> children;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      childrenButtonSize: Size(
        context.sized.dynamicWidth(0.6),
        context.sized.dynamicHeight(0.1),
      ),
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayColor: ColorCommon(context).whiteAndBlackForTheme,
      overlayOpacity: CustomOpacity.perCent60.value,
      spacing: WidgetSizes.spacingXsMid,
      children: children,
    );
  }
}
