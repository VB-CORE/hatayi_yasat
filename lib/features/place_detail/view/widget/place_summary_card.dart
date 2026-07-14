part of '../place_detail_view.dart';

final class PlaceSummaryCard extends ConsumerWidget with AppProviderStateMixin {
  const PlaceSummaryCard({
    required this.store,
    this.borderRadius = AppRadius.lg,
    this.showShadow = true,
    super.key,
  });

  final StoreModel store;
  final double borderRadius;
  final bool showShadow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(store.townCode);
    final hasPhone = store.phone.ext.isNotNullOrNoEmpty;
    final hasOwner = store.owner.ext.isNotNullOrNoEmpty;
    final hasTown = town.ext.isNotNullOrNoEmpty;
    final hasImage = store.images.firstOrNull.ext.isNotNullOrNoEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.ink50),
        boxShadow: showShadow ? AppShadows.card : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Row(
            spacing: AppSpacing.sm,
            children: [
              if (hasImage)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: CustomImageWithViewDialog(
                    image: store.images.firstOrNull,
                    height: context.sized.dynamicWidth(.15),
                    width: context.sized.dynamicWidth(.15),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xxs,
                  children: [
                    Text(
                      store.updatedName,
                      style: AppText.title.copyWith(color: AppColors.navy900),
                    ),
                    if (hasTown)
                      Text(
                        town,
                        style: AppText.bodySm.copyWith(
                          color: AppColors.navy500,
                        ),
                      ),
                    if (hasOwner)
                      Row(
                        spacing: AppSpacing.xxs,
                        children: [
                          const Icon(
                            AppIcons.person,
                            size: AppIconSizes.xMedium,
                            color: AppColors.navy400,
                          ),
                          Flexible(
                            child: Text(
                              store.owner,
                              style: AppText.bodySm.copyWith(
                                color: AppColors.navy400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          StatusPill(store: store),
          Row(
            spacing: AppSpacing.xs,
            children: [
              PlaceRatingLabel(rating: PlaceMetaMock(store).ratingLabel),
              Text(
                LocaleKeys.placeDetailView_reviewCount.tr(
                  args: ['${PlaceMetaMock(store).reviewCount}'],
                ),
                style: AppText.bodySm,
              ),
            ],
          ),
          Row(
            spacing: AppSpacing.xs,
            children: [
              if (hasPhone)
                Expanded(
                  child: CustomBounceable(
                    child: ElevatedButton.icon(
                      onPressed: () => _onCallPressed(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navy,
                      ),
                      label: Text(LocaleKeys.placeDetailView_call.tr()),
                      icon: const Icon(AppIcons.phone),
                    ),
                  ),
                ),
              Expanded(
                child: CustomBounceable(
                  child: ElevatedButton.icon(
                    onPressed: () => _onCommentPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.coral100,
                      foregroundColor: AppColors.coral700,
                    ),
                    label: Text(LocaleKeys.placeDetailView_makeComment.tr()),
                    icon: const Icon(AppIcons.comment),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onCallPressed(BuildContext context) {
    return RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: store.phone,
    );
  }

  Future<void> _onCommentPressed(BuildContext context) {
    return RateSheetFactory.showRateCard(
      context,
      placeId: store.documentId,
    );
  }
}
