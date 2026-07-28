part of '../../place_detail_view.dart';

final class PlaceDetailShowcaseSection extends ConsumerWidget {
  const PlaceDetailShowcaseSection({required this.placeId, super.key});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(placeShowcaseModulesProvider(placeId));

    if (modules.hasError) {
      return _PlaceShowcaseError(
        onRetry: () => ref.invalidate(placeShowcaseModulesProvider(placeId)),
      );
    }

    final items = modules.value ?? const <MerchantShowcaseModuleModel>[];
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        GeneralBodyTitle(
          LocaleKeys.merchantPanel_placeSection_title.tr(),
          color: AppColors.navy900,
          textAlign: TextAlign.start,
        ),
        for (final module in items) MerchantShowcaseCard(module: module),
      ],
    );
  }
}

final class _PlaceShowcaseError extends StatelessWidget {
  const _PlaceShowcaseError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GeneralContentSubTitle(
            value: LocaleKeys.message_somethingWentWrong.tr(),
          ),
        ),
        TextButton(
          onPressed: onRetry,
          child: Text(LocaleKeys.button_tryAgain.tr()),
        ),
      ],
    );
  }
}
