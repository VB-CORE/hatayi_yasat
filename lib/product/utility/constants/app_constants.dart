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
  static const int kFive = 5;
  static const int kFourteen = 14;

  /// [progressMaxValue] value is 100
  static const int progressMaxValue = 100;

  /// [defaultMapZoom] value is 14
  static const double defaultMapZoom = 14;

  static const String googleMapsPlaceLink =
      'https://www.google.com/maps/search/?api=1&query=';

  static const String homeWebsiteUrl = 'https://www.hatayiyasat.com/';

  static const String googleMapsUrl = 'comgooglemaps://?q=';
  static const String appleMapsUrl = 'maps://?q=';

  static const String appStoreId = 'id6465691080';
  static const String kiloByte = 'kb';
}
