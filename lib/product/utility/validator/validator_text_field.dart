import 'package:easy_localization/easy_localization.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

abstract class ValidatorField {
  String? validate(String? value);
  String? validateDateTime({
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    throw UnimplementedError();
  }
}

/// It is used for text field validation for general text
final class ValidatorNormalTextField extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    final trimmedValue = value.trim();
    if (trimmedValue.length < 3) return LocaleKeys.validation_generalText.tr();
    return null;
  }
}

/// It is used for text field validation
final class TextFieldValidatorIsNullEmpty extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }
    return null;
  }
}

/// It is used for date time validation
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

/// It is used for email validation
final class ValidatorEmailTextField extends ValidatorField {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_requiredField.tr();
    }

    if (value.length < AppConstants.kThree) {
      return LocaleKeys.validation_generalText.tr();
    }

    if (!value.ext.isValidEmail) return LocaleKeys.validation_emailFormat.tr();
    return null;
  }
}

/// It is used for phone number validation for kartal package formatter
final class ValidatorPhoneTextField extends ValidatorField {
  @override
  String? validate(String? value) {
    return value.ext.phoneFormatValue.ext.isNotNullOrNoEmpty
        ? null
        : LocaleKeys.validation_phoneNumber.tr();
  }
}
