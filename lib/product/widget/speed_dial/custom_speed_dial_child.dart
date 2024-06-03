import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/widget/general/index.dart';

class CustomSpeedDialChild extends SpeedDialChild {
  CustomSpeedDialChild({
    required BuildContext context,
    required Widget destination,
    required String label,
  }) : super(
          child: GeneralBodyTitle(
            label.tr(),
          ),
          onTap: () => context.route.navigateToPage(destination),
        );
}

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
