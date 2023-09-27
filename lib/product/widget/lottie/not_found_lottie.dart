import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class NotFoundLottie extends StatelessWidget {
  const NotFoundLottie({
    required this.title,
    required this.onRefresh,
    super.key,
  });
  final VoidCallback onRefresh;
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
            Assets.lottie.notFound.lottie(),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Text(title),
                TextButton(
                  onPressed: onRefresh,
                  child: Text(LocaleKeys.notFound_forRefresh.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
