import 'package:cloud_firestore/cloud_firestore.dart';

extension GeoPointX on GeoPoint {
  String get coordinates => '$latitude,$longitude';
}
