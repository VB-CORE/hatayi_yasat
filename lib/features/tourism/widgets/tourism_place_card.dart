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
    return TapArea(
      onTap: () => onItemTap(
        LatLng(location.latLong.latitude, location.latLong.longitude),
      ),
      child: Container(
        width: WidgetSizes.spacingXxlL12,
        decoration: BoxDecorations.tourismPlaceCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(WidgetSizes.spacingXl),
              ),
              child: SizedBox.square(
                dimension: WidgetSizes.spacingXxl12,
                child: CustomNetworkImage(
                  imageUrl: location.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const EmptyBox.xSmallHeight(),
            Expanded(
              child: Padding(
                padding: const PagePadding.allLow(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context),
                    const EmptyBox.smallHeight(),
                    Expanded(child: _buildDescription(context)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TapArea(
                        onTap: () {
                          ToursimPlaceDetailSheet.show(context, location);
                        },
                        child: Text(
                          LocaleKeys.button_more.tr(),
                          style: context.general.textTheme.bodySmall?.copyWith(
                            color: context.general.colorScheme.primary,
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.underline,
                            decorationThickness: .5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
