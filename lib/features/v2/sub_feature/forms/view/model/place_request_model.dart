import 'package:life_shared/life_shared.dart';

final class PlaceRequestModel {
  PlaceRequestModel({
    required this.placeName,
    required this.placeDescription,
    required this.placeOwnerName,
    required this.placeAddress,
    required this.placePhoneNumber,
    required this.placeCategory,
    required this.placeDistrict,
  });

  final String placeName;
  final String placeDescription;
  final String placeOwnerName;
  final String placeAddress;
  final String placePhoneNumber;
  final CategoryModel placeCategory;
  final TownModel placeDistrict;
}
