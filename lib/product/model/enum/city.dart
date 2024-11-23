import 'package:easy_localization/easy_localization.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

enum City {
  hatay(AppConstants.hatay, LocaleKeys.project_name),
  mersin(AppConstants.mersin, LocaleKeys.general_keepMersinAlive);

  const City(this.city, this.title);

  final String city;
  final String title;

  static String fromSelectedCity(String selectedCity) {
    return City.values
        .firstWhere(
          (City city) => city.city == selectedCity,
        )
        .title
        .tr();
  }
}
