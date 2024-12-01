import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

enum Locations {
  hatay(
    LatLng(AppConstants.hatayLatitude, AppConstants.hatayLongitude),
  ),
  mersin(
    LatLng(AppConstants.mersinLatitude, AppConstants.mersinLongitude),
  );

  const Locations(this.latLng);
  final LatLng latLng;
}
