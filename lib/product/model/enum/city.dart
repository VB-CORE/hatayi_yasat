import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

enum City {
  hatay(
    AppConstants.hatayId,
    AppConstants.hatay,
    LocaleKeys.project_name,
  ),
  mersin(
    AppConstants.mersinId,
    AppConstants.mersin,
    LocaleKeys.general_keepMersinAlive,
  );

  const City(this.cityId, this.city, this.title);

  final String cityId;
  final String city;
  final String title;
}
