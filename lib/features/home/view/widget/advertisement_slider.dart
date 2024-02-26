part of '../home_view.dart';

final class _AdvertisementSlider extends StatelessWidget {
  const _AdvertisementSlider();

  //TODO: replace list when backend ready!
  List<AdvertisementModel> get _mockAdvertisements =>
      const <AdvertisementModel>[
        AdvertisementModel.mock1(),
        AdvertisementModel.mock2(),
      ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTopMedium(),
      sliver: CarouselSlider(
        options: CustomCarouselOptions.advertisement(
          height: context.sized.dynamicHeight(.2),
        ),
        items: _mockAdvertisements.map((item) {
          return _buildItem(context, item);
        }).toList(),
      ).ext.sliver,
    );
  }

  Padding _buildItem(BuildContext context, AdvertisementModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetSizes.spacingXs,
      ),
      child: _AdvertisementItem(item),
    );
  }
}

final class _AdvertisementItem extends StatelessWidget {
  const _AdvertisementItem(this.item);

  final AdvertisementModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CustomNetworkImage(imageUrl: item.imageUrl),
      onTap: () async => _onPressed(context),
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
