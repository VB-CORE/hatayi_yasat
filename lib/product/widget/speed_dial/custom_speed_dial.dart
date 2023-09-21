import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/utility/opacity/custom_opacity.dart';
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
      childrenButtonSize: Size(
        context.sized.dynamicWidth(0.5),
        context.sized.dynamicHeight(0.1),
      ),
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayColor: ColorsCustom.black,
      overlayOpacity: CustomOpacity.perCent60.value,
      spacing: WidgetSizes.spacingXsMid,
      children: children,
    );
  }
}
