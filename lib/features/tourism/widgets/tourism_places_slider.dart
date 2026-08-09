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
  final CarouselSliderController carouselController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: _buildOptions(),
      items: locations.mapIndexed((index, location) {
        return _TourismPlaceCard(
          location: location,
          onItemTap: (latlng) {
            _animateToCard(index: index);
            onItemTap.call(location);
          },
        );
      }).toList(),
    );
  }

  void _animateToCard({required int index}) =>
      carouselController.animateToPage(index);

  static const double _railHeight = WidgetSizes.spacingXxlL13;

  /// Kartta yan yana iki aksiyon butonu var; daha dar bir orana inildiğinde
  /// etiketler sığmıyor.
  static const double _viewportFraction = .72;

  CarouselOptions _buildOptions() {
    return CarouselOptions(
      height: _railHeight,
      enableInfiniteScroll: false,
      padEnds: false,
      viewportFraction: _viewportFraction,
      onPageChanged: (index, reason) => onItemTap(
        locations[index],
      ),
    );
  }
}
