part of '../place_detail_view.dart';

/// Yorumlar tab — streams reviews from `reviewsRepositoryProvider` and
/// renders each via `V2ReviewCard`. Empty state shows neutral copy; the
/// floating "Yorum yaz" FAB on the parent triggers the composer sheet.
final class _PlaceDetailReviewsTab extends ConsumerWidget {
  const _PlaceDetailReviewsTab({
    required this.placeId,
    required this.onWriteReview,
  });

  final String placeId;
  final Future<void> Function() onWriteReview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(reviewsRepositoryProvider);
    return StreamBuilder<List<ReviewModel>>(
      stream: repo.watchForPlace(placeId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final reviews = snap.data ?? const <ReviewModel>[];
        if (reviews.isEmpty) {
          return SliverToBoxAdapter(
            child: _ReviewsEmpty(onWriteReview: onWriteReview),
          );
        }
        return SliverList.builder(
          itemCount: reviews.length,
          itemBuilder: (_, i) => V2ReviewCard(review: reviews[i]),
        );
      },
    );
  }
}

final class _ReviewsEmpty extends StatelessWidget {
  const _ReviewsEmpty({required this.onWriteReview});

  final Future<void> Function() onWriteReview;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 40,
            color: colorScheme.onSecondaryFixed,
          ),
          const EmptyBox.smallHeight(),
          Text(
            LocaleKeys.placeDetailV2_noReviews.tr(),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryFixedVariant,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
          const EmptyBox.middleHeight(),
          ElevatedButton.icon(
            onPressed: () => onWriteReview(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: CustomRadius.medium,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.rate_review_rounded, size: 18),
            label: Text(
              LocaleKeys.placeDetailV2_writeReview.tr(),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
