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
    placeName: 'Harika Restoran',
    placeDescription:
        'Harika Restoran, lezzetli yemekleri ve sıcak atmosferiyle ünlü bir mekan. Her bir yemek, özenle seçilmiş malzemelerle hazırlanır ve şeflerimiz tarafından ustalıkla sunulur. Menümüzde dünya mutfağından lezzetler bulabilir, her damak zevkine hitap eden özel tatlar deneyebilirsiniz.',
    placeOwnerName: 'Ahmet Yılmaz',
    placeAddress:
        'Güzel Sokak No: 123, Merkez Mahallesi, Şehir / Ülke Zemin Kat, Kapı No: 5',
    placePhoneNumber: '+90 123 456 7890',
    placeCategory: const CategoryModel(
      name: 'Restoran',
      value: 0,
    ),
    placeDistrict: TownModel(
      code: 0,
      name: 'Merkez',
    ),
  );
}
