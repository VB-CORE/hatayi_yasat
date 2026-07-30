part of '../merchant_panel_view.dart';

final class MerchantReviewFilterBar extends ConsumerWidget {
  const MerchantReviewFilterBar({
    required this.storeId,
    super.key,
  });

  final String storeId;

  String _labelOf(MerchantReviewFilter value) => switch (value) {
    MerchantReviewFilter.pending =>
      LocaleKeys.merchantPanel_reviews_filterPending.tr(),
    MerchantReviewFilter.all => LocaleKeys.merchantPanel_reviews_filterAll.tr(),
    MerchantReviewFilter.answered =>
      LocaleKeys.merchantPanel_reviews_filterAnswered.tr(),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(
      merchantReviewsViewModelProvider(storeId).select((state) => state.filter),
    );

    return Material(
      color: context.appColors.ink25,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const PagePadding.generalAllLow(),
        child: Row(
          spacing: AppSpacing.xs,
          children: [
            for (final value in MerchantReviewFilter.values)
              ChoiceChip(
                selected: filter == value,
                onSelected: (_) => ref
                    .read(merchantReviewsViewModelProvider(storeId).notifier)
                    .changeFilter(value),
                showCheckmark: false,
                selectedColor: context.appColors.coral,
                backgroundColor: context.appColors.surface,
                labelStyle: AppText.caption.copyWith(
                  color: filter == value
                      ? context.appColors.surface
                      : context.appColors.ink600,
                ),
                label: Text(_labelOf(value)),
              ),
          ],
        ),
      ),
    );
  }
}
