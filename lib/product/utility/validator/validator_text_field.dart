import 'package:easy_localization/easy_localization.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/regex_types.dart';

abstract class ValidatorField {
  String? validate(String? value);
  String? validateDateTime({
    required DateTime? startDate,
    required DateTime? endDate,
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

final class DateTimeValidator extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    return null;
  }

  @override
  String? validateDateTime({
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    if (startDate == null || endDate == null) return null;
    if (startDate.isAfter(endDate)) {
      return LocaleKeys.validation_requiredField.tr();
    }
    return null;
  }
}

final class ValidatorEmailTextField extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    if (value.length < 3) return LocaleKeys.validation_generalText.tr();

    if (!value.ext.isValidEmail) return LocaleKeys.validation_email_format.tr();
    if (!RegexTypes.studentMailRegex.hasMatch(value)) {
      return LocaleKeys.validation_student_email_format.tr();
    }
    return null;
  }
}
