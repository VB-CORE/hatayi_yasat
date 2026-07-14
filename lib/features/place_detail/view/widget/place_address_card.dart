part of '../place_detail_view.dart';

final class PlaceAddressCard extends StatelessWidget {
  const PlaceAddressCard({
    required this.latLong,
    super.key,
  });

  final GeoPoint latLong;

  @override
  Widget build(BuildContext context) {
    final position = LatLng(latLong.latitude, latLong.longitude);
    final cameraPosition = CameraPosition(target: position, zoom: 15);
    final markers = {
      Marker(
        markerId: MarkerId(latLong.toString()),
        position: position,
      ),
    };

    return CustomBounceable(
      onTap: _openMaps,
      scaleFactorOnTap: .98,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          height: context.sized.height * .18,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.navy100),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              IgnorePointer(
                child: RepaintBoundary(
                  child: GoogleMap(
                    initialCameraPosition: cameraPosition,
                    markers: markers,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    liteModeEnabled: true,
                  ),
                ),
              ),
              Positioned(
                right: AppSpacing.sm,
                top: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.navy700.withValues(alpha: .55),
                  ),
                  child: const Icon(
                    AppIcons.openInNew,
                    size: AppIconSizes.xMedium,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMaps() {
    return '${latLong.latitude},${latLong.longitude}'.ext.launchMaps();
  }
}
