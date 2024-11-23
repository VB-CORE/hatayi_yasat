import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String kWeb = 'kWeb';
const double kZero = 0;
const double kErrorNumber = -1;

@immutable
final class AppConstants {
  const AppConstants._();
  static const int kZero = 0;
  static const int kOne = 1;
  static const int kTwo = 2;
  static const int kThree = 3;
  static const int kFour = 4;
  static const int kFive = 5;
  static const int kTen = 10;
  static const int kFourteen = 14;

  /// [defaultMapZoom] value is 14
  static const double defaultMapZoom = 14;

  static const String homeWebsiteUrl = 'https://www.hatayiyasat.com/';

  static const String appStoreId = 'id6465691080';
  static const String kiloByte = 'kb';

  static const String appName = "Hatay'ı Yaşat";

  static const String hatay = 'Hatay';
  static const String mersin = 'Mersin';

  /// [initialLocation] is the initial position of the map from Hatay
  static const initialLocation = CameraPosition(
    target: LatLng(hatayLatitude, hatayLongitude),
    zoom: 10,
  );

  /// Latitude of Hatay.
  static const double hatayLatitude = 36.845487;

  /// Longitude of Hatay.
  static const double hatayLongitude = 36.221312;

  /// Latitude of Mersin.
  static const double mersinLatitude = 36.8;

  /// Longitude of Mersin.
  static const double mersinLongitude = 34.6333;
}
