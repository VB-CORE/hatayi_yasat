part of '../view/tourism_map_view.dart';

final class _TourismPlacesSlider extends StatelessWidget
    with GeoPointConverterMixin {
  const _TourismPlacesSlider({
    required this.locations,
    required this.onItemTap,
    required this.carouselController,
  });

  final List<TouristicPlaceModel> locations;
  final void Function(LatLng position) onItemTap;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: _buildOptions(),
      items: locations.mapIndexed((index, location) {
        return _TourismPlaceCard(
          location: location,
          onItemTap: (LatLng latlng) {
            _animateToCard(index: index);
            onItemTap(latlng);
          },
        );
      }).toList(),
    );
  }

  void _animateToCard({required int index}) =>
      carouselController.animateToPage(index);

  CarouselOptions _buildOptions() {
    return CarouselOptions(
      height: WidgetSizes.spacingXxlL12,
      enableInfiniteScroll: false,
      enlargeCenterPage: true,
      viewportFraction: 0.6,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      onPageChanged: (index, reason) => onItemTap(
        geoPointToLatLng(locations[index].latLong),
      ),
    );
  }
}
