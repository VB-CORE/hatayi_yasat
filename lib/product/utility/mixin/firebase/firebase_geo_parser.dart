import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirebaseCustomParser {
  static GeoPoint geoPointFromJson(GeoPoint geoPoint) {
    return GeoPoint(geoPoint.latitude, geoPoint.longitude);
  }

  static Map<String, dynamic> geoPointToJson(GeoPoint geoPoint) {
    return {
      'latitude': geoPoint.latitude,
      'longitude': geoPoint.longitude,
    };
  }
}
