part of '../view/tourism_map_view.dart';

final class _TourismPlaceCard extends StatelessWidget {
  const _TourismPlaceCard({required this.location, required this.onItemTap});

  final TouristicPlaceModel location;
  final void Function(LatLng position) onItemTap;

  static const double _imageHeight = WidgetSizes.spacingXxl12;
  static const int _descriptionLines = 2;
  static const double _placeholderTileSize = WidgetSizes.spacingXs;
  static const double _placeholderTileOpacity = 0.22;

  @override
  Widget build(BuildContext context) {
    final title = location.title;
    final description = location.description;

    return Padding(
      padding: const PagePadding.horizontalVeryLowSymmetric(),
      child: InkWell(
        onTap: () => onItemTap(
          GeoPointConverterMixin.geoPointToLatLng(location.latLong),
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.raised,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardImage(location: location),
              Padding(
                padding: const PagePadding.generalAllLow(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xxs,
                  children: [
                    if (title != null && title.isNotEmpty)
                      GeneralBodyTitle(
                        title,
                        fontWeight: FontWeight.w800,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    if (description != null && description.isNotEmpty)
                      GeneralContentSubTitle(
                        value: description,
                        maxLine: _descriptionLines,
                      ),
                    _CardActions(location: location),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _CardImage extends StatelessWidget {
  const _CardImage({required this.location});

  final TouristicPlaceModel location;

  @override
  Widget build(BuildContext context) {
    final photo = location.photo;

    return SizedBox(
      height: _TourismPlaceCard._imageHeight,
      width: double.infinity,
      child: photo == null || photo.isEmpty
          ? ColoredBox(
              color: context.appColors.navy,
              child: const MosaicBackground(
                showGradient: false,
                tileSize: _TourismPlaceCard._placeholderTileSize,
                tileOpacity: _TourismPlaceCard._placeholderTileOpacity,
              ),
            )
          : CustomNetworkImage(imageUrl: photo, fit: BoxFit.cover),
    );
  }
}

final class _CardActions extends StatelessWidget {
  const _CardActions({required this.location});

  final TouristicPlaceModel location;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.xs,
      children: [
        Expanded(
          child: GeneralButtonV2.active(
            action: () => LinkActions.directions(context, location.title),
            label: LocaleKeys.general_action_directions.tr(),
            icon: AppIcons.directions,
            backgroundColor: context.appColors.navy,
          ),
        ),
        Expanded(
          child: OutlineActionButton(
            labelKey: LocaleKeys.tourismView_detail,
            icon: AppIcons.info,
            onPressed: () => ToursimPlaceDetailSheet.show(context, location),
          ),
        ),
      ],
    );
  }
}
