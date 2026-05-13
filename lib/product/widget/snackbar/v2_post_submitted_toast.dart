import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 floating success toast shown after compose / memory submission.
///
/// Mirrors the V2 design's "post submitted" overlay: navy bar floating 80px
/// from the bottom, olive success badge, white display title + tagline.
/// Auto-dismisses after [duration].
void showV2PostSubmittedToast(
  BuildContext context, {
  String? title,
  String? body,
  Duration duration = const Duration(seconds: 3),
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      duration: duration,
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorsCustom.navy,
      elevation: 8,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 80),
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      content: _Body(
        title: title ?? LocaleKeys.compose_submitOk.tr(),
        body: body,
      ),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({required this.title, this.body});

  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            // Brand-locked olive success badge sits over the navy toast.
            color: ColorsCustom.olive.withValues(alpha: 0.25),
            borderRadius: CustomRadius.medium,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: ColorsCustom.olive300,
            size: 22,
          ),
        ),
        const EmptyBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow(
                LocaleKeys.compose_kindPost.tr(),
                color: ColorsCustom.coral300,
              ),
              const EmptyBox.xSmallHeight(),
              Text(
                title,
                style: V2Typography.display(
                  fontSize: 16,
                  color: ColorsCustom.white,
                ),
              ),
              if (body != null && body!.isNotEmpty) ...[
                const EmptyBox.xSmallHeight(),
                Text(
                  body!,
                  style: V2Typography.label(
                    fontSize: 11.5,
                    color: ColorsCustom.white.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
