import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class PlaceRequestModel extends Equatable {
  const PlaceRequestModel({
    required this.placeName,
    required this.placeDescription,
    required this.placeOwnerName,
    required this.placeAddress,
    required this.placePhoneNumber,
    required this.placeCategory,
    required this.placeDistrict,
    required this.imageFile,
  });

  final String placeName;
  final String placeDescription;
  final String placeOwnerName;
  final String placeAddress;
  final String placePhoneNumber;
  final CategoryModel placeCategory;
  final TownModel placeDistrict;
  final File imageFile;

  @override
  List<Object?> get props => [
        placeName,
        placeDescription,
        placeOwnerName,
        placeAddress,
        placePhoneNumber,
        placeDistrict,
        placeCategory,
        imageFile,
      ];
}
