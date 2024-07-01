import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class CustomSpeedDialRouteChild extends SpeedDialChild {
  CustomSpeedDialRouteChild({
    required BuildContext context,
    required String location,
    required String label,
  }) : super(
          child: GeneralBodyTitle(
            label,
          ),
          onTap: () => context.push(location),
        );
}
