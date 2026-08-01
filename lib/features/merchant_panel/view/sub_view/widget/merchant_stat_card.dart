part of '../merchant_dashboard_sub_view.dart';

final class _MerchantStatCard extends StatelessWidget {
  const _MerchantStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.allLow(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.appColors.ink200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xxs,
        children: [
          Icon(icon, size: AppIconSizes.xMedium, color: context.appColors.navy300),
          Text(value, style: AppText.displaySm),
          Text(
            label,
            maxLines: AppConstants.kOne,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption,
          ),
        ],
      ),
    );
  }
}
