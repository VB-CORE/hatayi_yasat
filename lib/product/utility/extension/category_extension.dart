import 'package:easy_localization/easy_localization.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

extension CategoryExtension on CategoryModel {
  static CategoryModel get emptyAll => CategoryModel(
        name: LocaleKeys.button_allFilter.tr(),
        value: kErrorNumber.toInt(),
      );

  static TownModel get emptyAllTown => TownModel(
        code: -1,
        name: LocaleKeys.button_allFilter.tr(),
      );
}
