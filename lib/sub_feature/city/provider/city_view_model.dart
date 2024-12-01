import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/product/model/enum/city.dart';
import 'package:lifeclient/sub_feature/city/provider/city_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_view_model.g.dart';

@riverpod
final class CityViewModel extends _$CityViewModel with ProjectDependencyMixin {
  @override
  CityState build() {
    return CityState(
      selectedCity: City.hatay.city,
    );
  }

  Future<void> fetchCities() async {
    final cities = await firebaseService.getList<StoreCityModel>(
      model: StoreCityModel(),
      path: CollectionPaths.approvedStoreCities,
    );
    state = state.copyWith(cityList: cities);
  }

  void changeSelectedCity(String newCity) {
    state = state.copyWith(selectedCity: newCity);
  }
}
