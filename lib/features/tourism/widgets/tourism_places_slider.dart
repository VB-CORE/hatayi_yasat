part of '../view/tourism_map_view.dart';

final class _TourismPlacesSlider extends ConsumerWidget
    with GeoPointConverterMixin {
  const _TourismPlacesSlider({
    required this.onItemTap,
    required this.carouselController,
  });

  final ValueChanged<TouristicPlaceModel> onItemTap;
  final CarouselSliderController carouselController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(
      tourismViewModelProvider.select((state) => state.placeList),
    );

    return CarouselSlider(
      carouselController: carouselController,
      options: _buildOptions(locations),
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
  static const double _viewportFraction = .72;

  CarouselOptions _buildOptions(List<TouristicPlaceModel> locations) {
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
