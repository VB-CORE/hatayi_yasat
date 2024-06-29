import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

final class ToursimCustomMarker extends Marker {
  ToursimCustomMarker({
    required TouristicPlaceModel model,
  }) : super(
          markerId: MarkerId(model.documentId),
          position: LatLng(model.latLong.latitude, model.latLong.longitude),
          infoWindow: InfoWindow(
            title: model.title,
            snippet: LocaleKeys.tourismView_onTapMarkerWindow.tr(),
            onTap: () {
              '${model.latLong.latitude},${model.latLong.longitude}'
                  .ext
                  .launchMaps();
            },
          ),
        );
}
