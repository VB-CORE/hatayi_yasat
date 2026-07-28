part of '../merchant_dashboard_sub_view.dart';

final class _MerchantManageTile extends StatelessWidget {
  const _MerchantManageTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.verticalLowSymmetric(),
      child: CustomBounceable(
        onTap: onTap,
        child: Container(
          padding: const PagePadding.allLow(),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.ink200),
          ),
          child: Row(
            spacing: AppSpacing.sm,
            children: [
              Container(
                padding: const PagePadding.allLow(),
                decoration: BoxDecoration(
                  color: AppColors.navy50,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: badgeCount > 0
                    ? Badge.count(
                        count: badgeCount,
                        child: Icon(
                          icon,
                          size: AppIconSizes.medium,
                          color: AppColors.navy400,
                        ),
                      )
                    : Icon(
                        icon,
                        size: AppIconSizes.medium,
                        color: AppColors.navy400,
                      ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.bodyLg),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodySm,
                    ),
                  ],
                ),
              ),
              const Icon(
                AppIcons.rightSelect,
                size: AppIconSizes.medium,
                color: AppColors.ink300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
