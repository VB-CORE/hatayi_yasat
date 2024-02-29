part of '../home_view.dart';

final class _AdvertisementSlider extends ConsumerWidget {
  const _AdvertisementSlider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(advertisementBoardViewModelProvider).advertisements;
    return SliverPadding(
      padding: const PagePadding.onlyTopMedium(),
      sliver: _buildSlider(context, items).ext.sliver,
    );
  }

  Widget _buildSlider(
    BuildContext context,
    List<AdBoardModel> items,
  ) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider(
      options: CustomCarouselOptions.advertisement(
        height: context.sized.dynamicHeight(.2),
      ),
      items: items.map((item) {
        return _buildItem(context, item);
      }).toList(),
    );
  }

  Padding _buildItem(BuildContext context, AdBoardModel item) {
    return Padding(
      padding: const PagePadding.vertical8Symmetric(),
      child: _AdvertisementItem(item),
    );
  }
}
