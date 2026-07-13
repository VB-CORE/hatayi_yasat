part of '../../place_detail_view.dart';

final class PlaceDetailAboutTab extends StatelessWidget {
  const PlaceDetailAboutTab({required this.store, super.key});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    final description = store.description.ext.isNullOrEmpty
        ? LocaleKeys.placeDetailView_noDescription.tr()
        : store.description!;
    final hasPhone = store.phone.ext.isNotNullOrNoEmpty;
    final hasAddress = store.address.ext.isNotNullOrNoEmpty;
    final latLong = store.latLong;
    final hasMap = hasAddress && latLong != null;
    final hasContactInfo = hasPhone || hasAddress || hasMap;

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
              description,
              style: AppText.body.copyWith(color: AppColors.navy400),
            ),
          ],
        ),
        if (hasContactInfo)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xs,
            children: [
              GeneralBodyTitle(
                LocaleKeys.placeDetailView_contactTitle.tr(),
                color: AppColors.navy900,
                textAlign: TextAlign.start,
              ),
              if (hasPhone)
                _ContactInfoTile(
                  icon: AppIcons.phone,
                  label: LocaleKeys.placeDetailView_phoneLabel.tr(),
                  value: store.phone,
                  action: TextButton(
                    onPressed: () => _onCallPressed(context),
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
              if (hasAddress)
                _ContactInfoTile(
                  icon: AppIcons.location,
                  label: LocaleKeys.placeDetailView_addressLabel.tr(),
                  value: store.address!,
                  valueMaxLines: 2,
                  action: IconButton(
                    onPressed: () => _onCopyAddressPressed(context),
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      AppIcons.copy,
                      color: AppColors.navy600,
                      size: AppIconSizes.medium,
                    ),
                    tooltip: LocaleKeys.button_copy.tr(),
                  ),
                ),
              if (hasMap) PlaceAddressCard(latLong: latLong),
            ],
          ),
      ],
    );
  }

  Future<void> _onCallPressed(BuildContext context) {
    return RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: store.phone,
    );
  }

  Future<void> _onCopyAddressPressed(BuildContext context) async {
    final address = store.address;
    if (address.ext.isNullOrEmpty) return;

    await address!.copyToClipboard();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Center(
            child: Text(LocaleKeys.message_copiedToClipboard.tr()),
          ),
          backgroundColor: AppColors.navy,
        ),
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
