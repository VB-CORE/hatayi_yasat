part of '../monetization_view.dart';

final class _MonetizationCard extends StatelessWidget {
  const _MonetizationCard({
    required this.coupon,
    required this.onDelete,
    required this.onRedeem,
    required this.onEdit,
  });

  final DiscountCouponModel coupon;
  final VoidCallback onDelete;
  final VoidCallback onRedeem;
  final VoidCallback onEdit;

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
                        '%${coupon.ratio ?? 0}',
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            coupon.desc ?? '',
                            style: AppText.bodyLg,
                          ),
                        ),

                        Bounceable(
                          onTap: onEdit,
                          child: const Padding(
                            padding: PagePadding.horizontalVeryLowSymmetric(),
                            child: Icon(
                              AppIcons.edit,
                              color: AppColors.ink500,
                              size: AppIconSizes.medium,
                            ),
                          ),
                        ),
                        Bounceable(
                          onTap: onDelete,
                          child: const Icon(
                            AppIcons.delete,
                            color: AppColors.ink500,
                            size: AppIconSizes.medium,
                          ),
                        ),
                      ],
                    ),
                    if (coupon.expiresAt case final expiresAt?)
                      Text(
                        LocaleKeys.monetization_expiresAtSummary.tr(
                          args: [expiresAt.dateTimeLabel],
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
                    Row(
                      children: [
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
                        const Spacer(),
                        if (!isInactive)
                          TextButton.icon(
                            onPressed: onRedeem,
                            icon: const Icon(
                              AppIcons.qrCode,
                              size: AppIconSizes.medium,
                            ),
                            label: Text(
                              LocaleKeys.monetization_redeem_redeemAction.tr(),
                            ),
                          ),
                      ],
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
