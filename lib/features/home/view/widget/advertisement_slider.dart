part of '../home_view.dart';

final class _AdvertisementSlider extends StatelessWidget {
  const _AdvertisementSlider();

  //TODO: replace list when backend ready!
  List<int> get _mockAdvertisements => const <int>[1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTopMedium(),
      sliver: CarouselSlider(
        options: _buildOptions(),
        items: _mockAdvertisements.map((_) {
          return _buildItem(context);
        }).toList(),
      ).ext.sliver,
    );
  }

  Padding _buildItem(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: WidgetSizes.spacingXs,
      ),
      child: _AdvertisementItem(),
    );
  }

  CarouselOptions _buildOptions() {
    return CarouselOptions(
      height: WidgetSizes.spacingXxl8 + WidgetSizes.spacingXxs,
      autoPlayAnimationDuration: DurationConstant.durationNormal,
      autoPlayCurve: Curves.easeOut,
      autoPlay: true,
    );
  }
}

class _AdvertisementItem extends StatelessWidget {
  const _AdvertisementItem();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const CustomNetworkImage(),
      onTap: () async => _onPressed(context),
    );
  }

  Future<void> _onPressed(BuildContext context) {
    //TODO: Don't show bottom sheet if image couldn't load
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const PagePadding.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralButtonV2.active(
                action: () {},
                //TODO: localize
                label: 'Linki Aç',
              ),
              Padding(
                padding: const PagePadding.onlyTop(),
                child: GeneralButtonV2.active(
                  action: () {},
                  //TODO: localize
                  label: 'Paylaş',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
