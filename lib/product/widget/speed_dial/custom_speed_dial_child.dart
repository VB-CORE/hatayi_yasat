import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kartal/kartal.dart';

class CustomSpeedDialChild extends SpeedDialChild {
  CustomSpeedDialChild({
    required BuildContext context,
    required Widget destination,
    required String label,
  }) : super(
          label: label.tr(),
          labelStyle: context.general.textTheme.titleMedium,
          onTap: () => context.route.navigateToPage(destination),
        );
}
