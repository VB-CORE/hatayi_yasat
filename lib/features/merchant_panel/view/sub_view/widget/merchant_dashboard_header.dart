part of '../merchant_dashboard_sub_view.dart';

final class _MerchantDashboardHeader extends StatelessWidget {
  const _MerchantDashboardHeader({
    required this.store,
    required this.averageScore,
  });

  final StoreModel store;
  final double averageScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllLow(),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.ink200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Row(
            spacing: AppSpacing.xs,
            children: [
              Container(
                padding: const PagePadding.allLow(),
                decoration: BoxDecoration(
                  color: AppColors.coral50,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  AppIcons.storeFilled,
                  size: AppIconSizes.large,
                  color: AppColors.coral,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.titleLg,
                    ),
                    Text(
                      store.category?.name ?? '',
                      style: AppText.bodySm,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.olive50,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.xxs,
                  children: [
                    const Icon(
                      AppIcons.checkFilled,
                      size: AppIconSizes.smallX,
                      color: AppColors.olive600,
                    ),
                    Text(
                      LocaleKeys.merchantPanel_approvedBadge.tr(),
                      style: AppText.micro.copyWith(color: AppColors.olive600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: AppSpacing.xs,
            children: [
              const Icon(
                AppIcons.star,
                size: AppIconSizes.xMedium,
                color: AppColors.gold,
              ),
              Text(averageScore.toStringAsFixed(1), style: AppText.label),
              Flexible(child: StatusPill(store: store)),
            ],
          ),
        ],
      ),
    );
  }
}
