import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

const String kWeb = 'kWeb';
const double kZero = 0;
const double kErrorNumber = -1;

@immutable
class AppConstants {
  const AppConstants._();
  static const int kZero = 0;
  static const int kOne = 1;
  static const int kTwo = 2;
  static const int kThree = 3;
  static const int kFour = 4;

  static const double defaultMapZoom = 14;

  static const String googleMapsPlaceLink =
      'https://www.google.com/maps/search/?api=1&query=';

  /// GeoPoint Constant
  static const GeoPoint hatayLatLong = GeoPoint(36.202509, 36.160290);
}
