part of '../history_view.dart';

@immutable
final class _HistoryGridBuilder extends ConsumerWidget {
  const _HistoryGridBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TEMP: Mock data kullanımı - test amaçlı
    final mockMemories =
        ref.read(historyViewModelProvider.notifier).getMockMemories();

    return Padding(
      padding: const PagePadding.onlyTopMedium() +
          const PagePadding.onlyBottomHigh(),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Instagram-like 3 columns
          crossAxisSpacing: WidgetSizes.spacingXxs,
          mainAxisSpacing: WidgetSizes.spacingXxs,
        ),
        itemCount: mockMemories.length,
        itemBuilder: (context, index) {
          final model = mockMemories[index];
          return _MemoryGridItem(
            model: model,
            onTap: () => _showPhotoDetailSheet(context, ref, model),
          );
        },
      ),
    );

    /* 
    // Gerçek Firebase implementasyonu - şimdilik yorumda
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
        childAspectRatio: 1, // Square images
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
    */
  }

  void _showPhotoDetailSheet(
    BuildContext context,
    WidgetRef ref,
    MemoryModel model,
  ) {
    final mockMemories =
        ref.read(historyViewModelProvider.notifier).getMockMemories();
    final selectedIndex = mockMemories.indexOf(model);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PhotoDetailSheet(
        memory: model,
        allMemories: mockMemories,
        initialIndex: selectedIndex,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: (model.imageUrls?.firstOrNull ?? '').isNotEmpty
              ? CustomNetworkImage(
                  imageUrl: model.imageUrls?.firstOrNull ?? '',
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.photo,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
