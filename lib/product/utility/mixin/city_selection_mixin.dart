import 'package:easy_localization/easy_localization.dart';
import 'package:lifeclient/product/model/enum/city.dart';

/// A mixin that provides utility methods for handling city-related selections.
mixin CitySelectionMixin {
  /// Retrieves the translated app bar title based on the `selectedCity` name.
  ///
  /// - [selectedCity]: The name of the city for which the AppBar title is needed.
  /// Returns the localized title for the `selectedCity`
  String getAppBarTitle(String selectedCity) {
    return City.values
        .firstWhere(
          (City city) => city.city == selectedCity,
        )
        .title
        .tr();
  }

  /// Retrieves the unique identifier (cityId) of a city based on its name.
  ///
  /// - [selectedCity]: The name of the city for which the cityId is needed.
  /// Returns the `cityId` corresponding to the selected city name.
  String getCityIdByName(String selectedCity) {
    return City.values
        .firstWhere(
          (City city) => city.city == selectedCity,
        )
        .cityId;
  }
}
