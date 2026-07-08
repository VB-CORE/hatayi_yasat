part of '../monetization_coupon_form_view.dart';

final class MonetizationDiscountRateSlider extends StatelessWidget {
  const MonetizationDiscountRateSlider({
    required this.value,
    required this.onChanged,
    super.key,
  });

  static const minRate = 5;
  static const maxRate = 100;
  static const step = 5;

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '${LocaleKeys.monetization_discountRate.tr()} ',
                  style: context.general.textTheme.labelLarge?.copyWith(
                    color: context.general.colorScheme.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: StringConstants.asteriks,
                      style: context.general.textTheme.bodyLarge?.copyWith(
                        color: AppColors.coral,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              LocaleKeys.monetization_discountRateValue.tr(args: ['$value']),
              style: AppText.displayMd.copyWith(color: AppColors.coral600),
            ),
          ],
        ),
        const EmptyBox.smallHeight(),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.coral,
            inactiveTrackColor: AppColors.ink100,
            thumbColor: AppColors.coral,
            overlayColor: AppColors.coral.withValues(alpha: 0.12),
            trackHeight: AppSpacing.xxs,
            padding: const PagePadding.horizontalLowSymmetric(),
          ),
          child: Slider(
            value: value.toDouble(),
            min: minRate.toDouble(),
            max: maxRate.toDouble(),
            divisions: (maxRate - minRate) ~/ step,
            onChanged: (rate) => onChanged(
              ((rate / step).round() * step).clamp(minRate, maxRate),
            ),
          ),
        ),
        Padding(
          padding: const PagePadding.horizontalLowSymmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.monetization_discountRateValue.tr(
                  args: ['$minRate'],
                ),
                style: AppText.caption.copyWith(color: AppColors.ink500),
              ),
              Text(
                LocaleKeys.monetization_discountRateValue.tr(
                  args: ['$maxRate'],
                ),
                style: AppText.caption.copyWith(color: AppColors.ink500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
