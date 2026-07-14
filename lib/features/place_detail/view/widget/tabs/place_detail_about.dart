part of '../../place_detail_view.dart';

final class PlaceDetailAboutTab extends StatelessWidget {
  const PlaceDetailAboutTab({
    required this.store,
    required this.onCall,
    required this.onCopyAddress,
    super.key,
  });

  final StoreModel store;
  final VoidCallback onCall;
  final VoidCallback onCopyAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xs,
          children: [
            GeneralBodyTitle(
              LocaleKeys.placeDetailView_aboutTitle.tr(),
              color: AppColors.navy900,
              textAlign: TextAlign.start,
            ),
            Text(
              store.hasDescription
                  ? store.description!
                  : LocaleKeys.placeDetailView_noDescription.tr(),
              style: AppText.body.copyWith(color: AppColors.navy400),
            ),
          ],
        ),
        if (store.hasContactInfo)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xs,
            children: [
              GeneralBodyTitle(
                LocaleKeys.placeDetailView_contactTitle.tr(),
                color: AppColors.navy900,
                textAlign: TextAlign.start,
              ),
              if (store.hasPhone)
                _ContactInfoTile(
                  icon: AppIcons.phone,
                  label: LocaleKeys.placeDetailView_phoneLabel.tr(),
                  value: store.phone,
                  action: TextButton(
                    onPressed: onCall,
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      foregroundColor: AppColors.navy,
                    ),
                    child: Text(
                      LocaleKeys.placeDetailView_call.tr(),
                      style: AppText.bodySm.copyWith(
                        color: AppColors.navy600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (store.hasAddress)
                _ContactInfoTile(
                  icon: AppIcons.location,
                  label: LocaleKeys.placeDetailView_addressLabel.tr(),
                  value: store.address!,
                  valueMaxLines: 3,
                  action: IconButton(
                    onPressed: onCopyAddress,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      AppIcons.copy,
                      color: AppColors.navy600,
                      size: AppIconSizes.medium,
                    ),
                    tooltip: LocaleKeys.button_copy.tr(),
                  ),
                ),
              if (store.hasMap) PlaceAddressCard(latLong: store.latLong!),
            ],
          ),
      ],
    );
  }
}

final class _ContactInfoTile extends StatelessWidget {
  const _ContactInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.action,
    this.valueMaxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget action;
  final int valueMaxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: const BoxDecoration(
              color: AppColors.navy50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppIconSizes.xMedium,
              color: AppColors.navy400,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppText.bodySm.copyWith(color: AppColors.navy400),
                ),
                Text(
                  value,
                  maxLines: valueMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodySm.copyWith(
                    color: AppColors.navy600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          action,
        ],
      ),
    );
  }
}
