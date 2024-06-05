part of '../view/tourism_map_view.dart';

final class _TourismPlacesSlider extends StatelessWidget {
  const _TourismPlacesSlider({
    required this.locations,
    required this.onItemTap,
  });

  final List<TourismMapModel> locations;
  final void Function(LatLng position) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalHighSymmetric(),
      child: CarouselSlider(
        options: _buildOptions(),
        items: locations.map((location) {
          return _TourismPlaceCard(
            location: location,
            onItemTap: onItemTap,
          );
        }).toList(),
      ),
    );
  }

  CarouselOptions _buildOptions() {
    return CarouselOptions(
      height: WidgetSizes.spacingXxl9,
      enableInfiniteScroll: false,
      enlargeCenterPage: true,
      viewportFraction: 0.64,
    );
  }
}
