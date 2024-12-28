import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';

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
    required this.timeValidationModel,
    required this.selectedLocation,
    required this.selectedCityId,
  });

  final String placeName;
  final String placeDescription;
  final String placeOwnerName;
  final String placeAddress;
  final String placePhoneNumber;
  final CategoryModel placeCategory;
  final TownModel placeDistrict;
  final File imageFile;
  final OpenAndCloseTimeValidationModel timeValidationModel;
  final LatLng selectedLocation;
  final String selectedCityId;

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
        timeValidationModel,
        selectedLocation,
        selectedCityId,
      ];
}
