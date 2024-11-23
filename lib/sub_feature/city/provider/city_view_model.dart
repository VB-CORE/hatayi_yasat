import 'package:lifeclient/product/model/enum/city.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_view_model.g.dart';

@riverpod
final class CityViewModel extends _$CityViewModel {
  @override
  String build() => City.hatay.city;

  // ignore: avoid_setters_without_getters
  set city(String newCity) => state = newCity;
}
