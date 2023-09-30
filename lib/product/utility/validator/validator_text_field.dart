import 'package:easy_localization/easy_localization.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

abstract class ValidatorField {
  String? validate(String? value);
  String? validateDateTime({
    required DateTime? startDate,
  }) {
    throw UnimplementedError();
  }
}

final class ValidatorNormalTextField extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    if (value.length < 3) return LocaleKeys.validation_generalText.tr();
    return null;
  }
}

final class TextFieldValidatorIsNullEmpty extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    return null;
  }
}
