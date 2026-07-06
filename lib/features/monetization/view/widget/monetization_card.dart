import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/number_extension.dart';

final class MonetizationCard extends StatelessWidget {
  const MonetizationCard({required this.coupon, super.key});

  final DiscountCouponModel coupon;

  String get _statusLabel {
    if (coupon.isExpired) return LocaleKeys.monetization_inactive.tr();
    if (coupon.isUsageLimitReached) {
      return LocaleKeys.monetization_usageLimitReached.tr();
    }
    return LocaleKeys.monetization_active.tr();
  }

  @override
  Widget build(BuildContext context) {
    final isInactive = coupon.isInactive;

    final backgroundColor = isInactive ? Colors.transparent : AppColors.white;

    final discounCardColor = isInactive ? AppColors.ink200 : AppColors.navy;
    final onDiscountCardColor = isInactive ? AppColors.ink600 : AppColors.white;

    final statusColor = isInactive ? AppColors.ink200 : AppColors.olive100;
    final onStatusColor = isInactive ? AppColors.ink600 : AppColors.olive700;

    return Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.card,
        side: const BorderSide(color: AppColors.navy100),
      ),
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: ClipPath(
                clipper: _CouponLeftClipper(),
                child: ColoredBox(
                  color: discounCardColor,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        '%${coupon.discountRate ?? 0}',
                        style: AppText.displayLg.copyWith(
                          color: onDiscountCardColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        LocaleKeys.monetization_discountCodeLabel.tr(),
                        style: AppText.body.copyWith(
                          color: onDiscountCardColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const PagePadding.allLow(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      coupon.desc ?? '',
                      style: AppText.bodyLg,
                    ),
                    if (coupon.expiresAt case final expiresAt?)
                      Text(
                        LocaleKeys.monetization_expiresAtSummary.tr(
                          args: [
                            DateFormat.yMMMd(
                              context.locale.toLanguageTag(),
                            ).format(expiresAt.toLocal()),
                          ],
                        ),
                        style: AppText.bodySm.copyWith(color: AppColors.ink500),
                      ),
                    Text(
                      LocaleKeys.monetization_usageCountSummary.tr(
                        args: [
                          if (coupon.usageLimit != null)
                            '${(coupon.usageCount ?? 0).decimalPattern(context)}/${coupon.usageLimit!.decimalPattern(context)}'
                          else
                            (coupon.usageCount ?? 0).decimalPattern(context),
                        ],
                      ),
                      style: AppText.bodySm.copyWith(fontWeight: .bold),
                    ),
                    Container(
                      padding:
                          const PagePadding.horizontalLowSymmetric() +
                          const PagePadding.verticalVeryLowSymmetric(),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: AppRadius.card,
                      ),
                      child: Text(
                        _statusLabel,
                        style: AppText.bodySm.copyWith(
                          color: onStatusColor,
                          fontWeight: .bold,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _CouponLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 6.0;
    const notchGap = 12.0;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    var y = notchGap;

    while (y < size.height) {
      path
        ..lineTo(size.width, y - notchRadius)
        ..quadraticBezierTo(
          size.width - notchRadius,
          y,
          size.width,
          y + notchRadius,
        );

      y += notchGap;
    }

    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
