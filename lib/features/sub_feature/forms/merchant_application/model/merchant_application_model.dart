import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';

final class MerchantApplicationModel extends Equatable {
  const MerchantApplicationModel({
    required this.placeName,
    required this.placeDescription,
    required this.placeAddress,
    required this.placeOwnerName,
    required this.placePhoneNumber,
    required this.placeCategory,
    required this.placeDistrict,
    required this.photoFiles,
    required this.photoUrls,
    required this.documentFile,
    required this.timeValidationModel,
    required this.selectedLocation,
    required this.selectedCityId,
    required this.isComment,
    required this.ownerId,
  });

  final String placeName;
  final String placeDescription;
  final String placeAddress;
  final String placeOwnerName;
  final String placePhoneNumber;
  final CategoryModel placeCategory;
  final TownModel placeDistrict;
  final List<File> photoFiles;
  final List<String> photoUrls;
  final File documentFile;
  final OpenAndCloseTimeValidationModel timeValidationModel;
  final LatLng selectedLocation;
  final String selectedCityId;
  final bool isComment;
  final String ownerId;

  @override
  List<Object?> get props => [
    placeName,
    placeDescription,
    placeAddress,
    placeOwnerName,
    placePhoneNumber,
    placeCategory,
    placeDistrict,
    photoFiles,
    photoUrls,
    documentFile,
    timeValidationModel,
    selectedLocation,
    selectedCityId,
    isComment,
    ownerId,
  ];
}
