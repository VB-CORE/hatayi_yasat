import 'package:life_shared/life_shared.dart';

final class CityState {
  const CityState({
    required this.selectedCity,
    this.cityList,
  });

  final List<StoreCityModel>? cityList;
  final String selectedCity;

  CityState copyWith({
    List<StoreCityModel>? cityList,
    String? selectedCity,
  }) {
    return CityState(
      cityList: cityList ?? this.cityList,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}
