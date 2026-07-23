part of '../place_detail_view.dart';

final class PlaceSummaryCard extends ConsumerWidget with AppProviderStateMixin {
  const PlaceSummaryCard({
    required this.store,
    required this.onCall,
    required this.onComment,
    super.key,
  });

  final StoreModel store;
  final VoidCallback onCall;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(store.townCode);
    final meta = PlaceMetaMock(store);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        _SummaryHeader(store: store, town: town),
        StatusPill(store: store),
        _SummaryRatingRow(meta: meta),
        _SummaryActions(store: store, onCall: onCall, onComment: onComment),
      ],
    );
  }
}

final class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.store, required this.town});

  final StoreModel store;
  final String town;

  @override
  Widget build(BuildContext context) {
    final imageSize = context.sized.dynamicWidth(.15);
    final hasTown = town.ext.isNotNullOrNoEmpty;

    return Row(
      spacing: AppSpacing.sm,
      children: [
        if (store.hasImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: CustomImageWithViewDialog(
              image: store.coverImage,
              height: imageSize,
              width: imageSize,
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
                  style: AppText.bodySm.copyWith(color: AppColors.navy500),
                ),
              if (store.hasOwner) _SummaryOwnerRow(owner: store.owner),
            ],
          ),
        ),
      ],
    );
  }
}

final class _SummaryOwnerRow extends StatelessWidget {
  const _SummaryOwnerRow({required this.owner});

  final String owner;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.xxs,
      children: [
        const Icon(
          AppIcons.person,
          size: AppIconSizes.xMedium,
          color: AppColors.navy400,
        ),
        Flexible(
          child: Text(
            owner,
            style: AppText.bodySm.copyWith(color: AppColors.navy400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

final class _SummaryRatingRow extends StatelessWidget {
  const _SummaryRatingRow({required this.meta});

  final PlaceMetaMock meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.xs,
      children: [
        PlaceRatingLabel(rating: meta.ratingLabel),
        Text(
          LocaleKeys.placeDetailView_reviewCount.tr(
            args: ['${meta.reviewCount}'],
          ),
          style: AppText.bodySm,
        ),
      ],
    );
  }
}

final class _SummaryActions extends StatelessWidget {
  const _SummaryActions({
    required this.store,
    required this.onCall,
    required this.onComment,
  });

  final StoreModel store;
  final VoidCallback onCall;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.xs,
      children: [
        if (store.hasPhone)
          Expanded(
            child: CustomBounceable(
              child: ElevatedButton.icon(
                onPressed: onCall,
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
              onPressed: onComment,
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
    );
  }
}
