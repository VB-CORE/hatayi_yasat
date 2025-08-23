part of '../history_view.dart';

@immutable
final class _HistoryGridBuilder extends ConsumerWidget {
  const _HistoryGridBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query =
        ref.read(historyViewModelProvider.notifier).fetchMemoriesQuery();

    return FirestoreGridView(
      query: query,
      padding: const PagePadding.onlyTopMedium() +
          const PagePadding.onlyBottomHigh(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Instagram-like 3 columns
        crossAxisSpacing: WidgetSizes.spacingXxs,
        mainAxisSpacing: WidgetSizes.spacingXxs,
      ),
      emptyBuilder: (_) => GeneralNotFoundWidget(
        title: LocaleKeys.notFound_image.tr(),
        onRefresh: () {},
      ),
      itemBuilder: (context, doc) {
        final model = doc.data();
        if (model == null) return const SizedBox.shrink();
        return _MemoryGridItem(
          model: model,
          onTap: () => _showPhotoDetailSheet(context, ref, model),
        );
      },
    );
  }

  void _showPhotoDetailSheet(
    BuildContext context,
    WidgetRef ref,
    MemoryModel model,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HistoryPhotoDetailSheet(
        memory: model,
      ),
    );
  }
}

@immutable
final class _MemoryGridItem extends StatelessWidget {
  const _MemoryGridItem({
    required this.model,
    required this.onTap,
  });

  final MemoryModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final firstImageUrl = model.imageUrls?.firstOrNull ?? '';
    if (firstImageUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: CustomRadius.small,
        ),
        child: ClipRRect(
          borderRadius: CustomRadius.small,
          child: CustomNetworkImage(
            imageUrl: firstImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
