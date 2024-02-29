part of '../home_view.dart';

final class _AdvertisementSlider extends StatelessWidget {
  const _AdvertisementSlider();

  //TODO: replace list when backend ready!
  List<AdvertisementModel> get _mockAdvertisements =>
      const <AdvertisementModel>[
        AdvertisementModel.mock1(),
        AdvertisementModel.mock2(),
        AdvertisementModel.mock3(),
      ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTopMedium(),
      sliver: CarouselSlider.builder(
        itemBuilder: (context, index, realIndex) =>
            _AdvertisementItem(_mockAdvertisements[index]),
        options: CustomCarouselOptions.advertisement(),
        itemCount: _mockAdvertisements.length,
      ).ext.sliver,
    );
  }
}

final class _AdvertisementItem extends StatelessWidget {
  const _AdvertisementItem(this.item);

  final AdvertisementModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetSizes.spacingXs,
      ),
      child: InkWell(
        child: CustomNetworkImage(imageUrl: item.imageUrl),
        onTap: () async => _onPressed(context),
      ),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    if (item.link.ext.isNotNullOrNoEmpty) {
      return showModalBottomSheet<void>(
        builder: (_) => _AdvertisementDetailView(item),
        context: context,
      );
    }
  }
}
