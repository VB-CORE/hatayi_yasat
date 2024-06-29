part of '../view/tourism_map_view.dart';

final class _TourismPlacesSlider extends StatelessWidget
    with GeoPointConverterMixin {
  const _TourismPlacesSlider({
    required this.locations,
    required this.onItemTap,
    required this.carouselController,
  });

  final List<TouristicPlaceModel> locations;
  final ValueChanged<TouristicPlaceModel> onItemTap;
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
            onItemTap.call(location);
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
      padEnds: false,
      viewportFraction: .6,
      onPageChanged: (index, reason) => onItemTap(
        locations[index],
      ),
    );
  }
}
