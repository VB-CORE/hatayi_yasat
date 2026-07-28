part of '../merchant_reviews_sub_view.dart';

final class _MerchantReviewFilterBar extends StatelessWidget {
  const _MerchantReviewFilterBar({
    required this.state,
    required this.onChanged,
  });

  final MerchantReviewsState state;
  final ValueChanged<MerchantReviewFilter> onChanged;

  String _labelOf(MerchantReviewFilter filter) => switch (filter) {
    MerchantReviewFilter.pending =>
      LocaleKeys.merchantPanel_reviews_filterPending.tr(
        args: ['${state.pendingReviews.length}'],
      ),
    MerchantReviewFilter.all => LocaleKeys.merchantPanel_reviews_filterAll.tr(
      args: ['${state.comments.length}'],
    ),
    MerchantReviewFilter.answered =>
      LocaleKeys.merchantPanel_reviews_filterAnswered.tr(
        args: ['${state.answeredReviews.length}'],
      ),
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const PagePadding.generalAllLow(),
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          for (final filter in MerchantReviewFilter.values)
            ChoiceChip(
              selected: state.filter == filter,
              onSelected: (_) => onChanged(filter),
              showCheckmark: false,
              selectedColor: AppColors.coral,
              backgroundColor: AppColors.surface,
              labelStyle: AppText.caption.copyWith(
                color: state.filter == filter
                    ? AppColors.surface
                    : AppColors.ink600,
              ),
              label: Text(_labelOf(filter)),
            ),
        ],
      ),
    );
  }
}
