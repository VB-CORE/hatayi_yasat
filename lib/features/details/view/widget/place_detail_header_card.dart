part of '../place_detail_view.dart';

/// Header card that overlaps the hero by -32px. Coral eyebrow with
/// category/neighborhood, DM-serif title, status pill + star rating,
/// then 3 action buttons.
final class _PlaceDetailHeaderCard extends ConsumerWidget {
  const _PlaceDetailHeaderCard({
    required this.model,
    required this.onCall,
    required this.onDirections,
    required this.onWriteReview,
  });

  final StoreModel model;
  final Future<void> Function() onCall;
  final Future<void> Function() onDirections;
  final Future<void> Function() onWriteReview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: CustomRadius.large,
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderEyebrow(model: model),
            const EmptyBox.xSmallHeight(),
            Text(
              model.name,
              style: V2Typography.display(
                fontSize: 22,
                color: colorScheme.onSurface,
              ),
            ),
            const EmptyBox.xSmallHeight(),
            _NeighborhoodLine(townCode: model.townCode),
            const EmptyBox.smallHeight(),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusPill(
                  isOpen: model.isOpenNow,
                  hours: model.hoursLabel.isEmpty ? null : model.hoursLabel,
                  size: StatusPillSize.sm,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: colorScheme.tertiary,
                    ),
                    const EmptyBox(width: 3),
                    Text(
                      model.ratingFallback.toStringAsFixed(1),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const EmptyBox(width: 4),
                    Text(
                      '(${LocaleKeys.placeDetailV2_reviewCount.tr(namedArgs: {'count': '${model.reviewCountFallback}'})})',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondaryFixed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const EmptyBox.middleHeight(),
            _PlaceDetailActionButtons(
              onCall: onCall,
              onDirections: onDirections,
              onWriteReview: onWriteReview,
            ),
          ],
        ),
      ),
    );
  }
}

final class _HeaderEyebrow extends StatelessWidget {
  const _HeaderEyebrow({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Eyebrow(model.categoryLabel.toUpperCase());
  }
}

final class _NeighborhoodLine extends ConsumerWidget
    with AppProviderStateMixin {
  const _NeighborhoodLine({required this.townCode});

  final int townCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final town = townCode == 0
        ? ''
        : productProvider(ref).fetchTownFromCode(townCode);
    if (town.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 13,
          color: colorScheme.onSecondaryFixed,
        ),
        const EmptyBox(width: 4),
        Flexible(
          child: Text(
            town,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSecondaryFixed,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
