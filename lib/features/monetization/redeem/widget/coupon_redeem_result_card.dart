part of '../coupon_redeem_view.dart';

final class _CouponRedeemResultCard extends StatelessWidget {
  const _CouponRedeemResultCard({
    required this.result,
    required this.onScanAgain,
  });

  final CouponRedeemResult result;
  final VoidCallback onScanAgain;

  @override
  Widget build(BuildContext context) {
    if (result is CouponRedeemIdle) {
      return Text(
        LocaleKeys.monetization_redeem_scanHint.tr(),
        textAlign: TextAlign.center,
        style: AppText.bodySm,
      );
    }

    final (icon, color, title, subtitle) = switch (result) {
      CouponRedeemIdle() => (AppIcons.qrCode, AppColors.navy400, '', ''),
      CouponRedeemGranted() => (
        AppIcons.checkFilled,
        AppColors.olive600,
        LocaleKeys.monetization_redeem_grantedTitle.tr(),
        LocaleKeys.monetization_redeem_grantedSubtitle.tr(),
      ),
      CouponRedeemAlreadyUsed(:final redeemedAt) => (
        AppIcons.cancelFilled,
        AppColors.coral600,
        LocaleKeys.monetization_redeem_alreadyUsedTitle.tr(),
        redeemedAt == null
            ? LocaleKeys.monetization_redeem_alreadyUsedSubtitle.tr()
            : LocaleKeys.monetization_redeem_alreadyUsedAt.tr(
                args: [redeemedAt.shortDate],
              ),
      ),
      CouponRedeemFailed(:final error) => (
        AppIcons.infoFilled,
        AppColors.coral600,
        LocaleKeys.monetization_redeem_failedTitle.tr(),
        switch (error) {
          CouponRedeemError.invalidQr =>
            LocaleKeys.monetization_redeem_invalidQr.tr(),
          CouponRedeemError.expired =>
            LocaleKeys.monetization_redeem_expired.tr(),
          CouponRedeemError.usageLimitReached =>
            LocaleKeys.monetization_redeem_usageLimitReached.tr(),
          CouponRedeemError.failed =>
            LocaleKeys.message_somethingWentWrong.tr(),
        },
      ),
    };

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const PagePadding.generalAllLow(),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: color),
          ),
          child: Column(
            spacing: AppSpacing.xxs,
            children: [
              Icon(icon, size: AppIconSizes.large, color: color),
              Text(title, style: AppText.title.copyWith(color: color)),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppText.bodySm,
              ),
            ],
          ),
        ),
        const EmptyBox.smallHeight(),
        GeneralButtonV2.active(
          action: onScanAgain,
          label: LocaleKeys.monetization_redeem_scanAgain.tr(),
        ),
      ],
    );
  }
}
