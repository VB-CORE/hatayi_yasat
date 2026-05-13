import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

final class MerchantApplicationInput {
  const MerchantApplicationInput({
    required this.placeName,
    required this.placeCategory,
    required this.description,
    required this.photoFiles,
    required this.phone,
    required this.address,
    required this.hours,
    required this.ownerName,
    required this.taxNumber,
    required this.registryNumber,
    required this.documentFiles,
    this.location,
  });

  final String placeName;
  final String placeCategory;
  final String description;
  final List<File> photoFiles;
  final String phone;
  final String address;
  final GeoPoint? location;
  final String hours;
  final String ownerName;
  final String taxNumber;
  final String registryNumber;
  final List<File> documentFiles;
}
