part of '../campaigns_view.dart';

class _SliderBuilder extends ConsumerWidget {
  const _SliderBuilder({required this.items});
  final List<CampaignModel> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: CarouselSlider.builder(
        options: _options(),
        itemCount: items.length,
        itemBuilder: (_, index, __) => CampaignPlaceCard(
          item: items[index],
          onTap: () {},
        ),
      ),
    );
  }

  CarouselOptions _options() => CarouselOptions(
        viewportFraction: AppConstants.kOne / AppConstants.kTwo,
        enlargeFactor: AppConstants.kOne / AppConstants.kTwo,
        initialPage: AppConstants.kOne,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      );
}
