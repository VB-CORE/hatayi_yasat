import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class GeneralNotFoundWidget extends StatelessWidget {
  const GeneralNotFoundWidget({
    required this.title,
    this.onRefresh,
    super.key,
  });
  final VoidCallback? onRefresh;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.height,
      width: context.sized.width,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: context.sized.dynamicHeight(.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svg.svgNotFound.svg(
              height: context.sized.dynamicHeight(.16),
              width: context.sized.dynamicWidth(.16),
            ),
            const SizedBox(height: WidgetSizes.spacingL),
            Padding(
              padding: const PagePadding.all(),
              child: GeneralContentSubTitle(
                value: title,
                maxLine: TextFieldMaxLengths.maxLine,
                textAlign: TextAlign.center,
              ),
            ),
            if (onRefresh != null)
              TextButton(
                onPressed: onRefresh,
                child: Text(LocaleKeys.notFound_forRefresh.tr()),
              ),
          ],
        ),
      ),
    );
  }
}
