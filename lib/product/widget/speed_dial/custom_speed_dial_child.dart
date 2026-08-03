import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class CustomSpeedDialRouteChild extends SpeedDialChild {
  CustomSpeedDialRouteChild({
    required BuildContext context,
    required String location,
    required String label,
    bool showLoginRequiredHint = false,
  }) : super(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             GeneralBodyTitle(label),
             if (showLoginRequiredHint) ...[
               const EmptyBox.xxSmallHeight(),
               GeneralContentSmallTitle(
                 value: LocaleKeys.component_speedDial_loginRequiredHint.tr(),
               ),
             ],
           ],
         ),
         onTap: () => context.go(location),
       );
}
