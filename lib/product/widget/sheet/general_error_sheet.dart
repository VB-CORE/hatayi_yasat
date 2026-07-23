import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class GeneralErrorSheet extends StatelessWidget {
  const GeneralErrorSheet({required this.title, super.key});

  final String title;

  static Future<bool?> show(BuildContext context, {required String title}) {
    return showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      builder: (_) => GeneralErrorSheet(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.svg.svgNotFound.svg(
              height: context.sized.dynamicHeight(.14),
              width: context.sized.dynamicWidth(.14),
            ),
            const SizedBox(height: WidgetSizes.spacingL),
            GeneralContentSubTitle(
              value: title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: WidgetSizes.spacingL),
            GeneralButtonV2.active(
              label: LocaleKeys.networkCheck_button.tr(),
              action: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }
}
