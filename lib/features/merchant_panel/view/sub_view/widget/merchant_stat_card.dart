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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.ink200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xxs,
        children: [
          Icon(icon, size: AppIconSizes.xMedium, color: AppColors.navy300),
          Text(value, style: AppText.displaySm),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption,
          ),
        ],
      ),
    );
  }
}
