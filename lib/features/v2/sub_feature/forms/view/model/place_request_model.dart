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

  // create dummy data for testing
  static PlaceRequestModel dummyData = PlaceRequestModel(
    placeName: 'Place Name',
    placeDescription: 'Place Description',
    placeOwnerName: 'Author',
    placeAddress: 'Place Address',
    placePhoneNumber: 'Place Phone Number',
    placeCategory: const CategoryModel(
      name: 'Category 0',
      value: 0,
    ),
    placeDistrict: const TownModel(
      code: 0,
      name: 'Town 0',
    ),
  );
}
