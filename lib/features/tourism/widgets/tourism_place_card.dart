part of '../view/tourism_map_view.dart';

final class _TourismPlaceCard extends StatelessWidget {
  const _TourismPlaceCard({
    required this.location,
    required this.onItemTap,
  });

  final TouristicPlaceModel location;
  final void Function(LatLng position) onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemTap(
        LatLng(location.latLong.latitude, location.latLong.longitude),
      ),
      child: Container(
        width: WidgetSizes.spacingXxlL12,
        decoration: BoxDecorations.tourismPlaceCard(),
        child: Padding(
          padding: const PagePadding.allLow(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(context),
              const SizedBox(height: 5),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildDescription(BuildContext context) {
    return Text(
      location.description ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      location.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
