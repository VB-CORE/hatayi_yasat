import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';

final class MerchantApplicationModel extends Equatable {
  const MerchantApplicationModel({
    required this.placeName,
    required this.placeDescription,
    required this.placeOwnerName,
    required this.placePhoneNumber,
    required this.placeCategory,
    required this.placeDistrict,
    required this.photoFiles,
    required this.documentFile,
    required this.timeValidationModel,
    required this.selectedLocation,
    required this.selectedCityId,
    required this.isComment,
  });

  final String placeName;
  final String placeDescription;
  final String placeOwnerName;
  final String placePhoneNumber;
  final CategoryModel placeCategory;
  final TownModel placeDistrict;
  final List<File> photoFiles;
  final File documentFile;
  final OpenAndCloseTimeValidationModel timeValidationModel;
  final LatLng selectedLocation;
  final String selectedCityId;
  final bool isComment;

  @override
  List<Object?> get props => [
    placeName,
    placeDescription,
    placeOwnerName,
    placePhoneNumber,
    placeCategory,
    placeDistrict,
    photoFiles,
    documentFile,
    timeValidationModel,
    selectedLocation,
    selectedCityId,
    isComment,
  ];
}
