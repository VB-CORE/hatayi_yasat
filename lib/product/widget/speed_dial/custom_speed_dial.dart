import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';

class CustomSpeedDial extends StatelessWidget {
  const CustomSpeedDial({
    required this.children,
    super.key,
  });

  final List<SpeedDialChild> children;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: WidgetSizes.spacingXsMid,
      switchLabelPosition: true,
      children: children,
    );
  }
}
