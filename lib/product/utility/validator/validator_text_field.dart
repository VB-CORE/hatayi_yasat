import 'package:easy_localization/easy_localization.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';

abstract class ValidatorField {
  String? validate(String? value) {
    throw UnimplementedError();
  }

  String? validateDateTime({
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    throw UnimplementedError();
  }

  String? validateDropDownField(BaseDropDownModel? value) {
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

/// It is used for optional text fields where no validation is required
final class ValidatorOptionalTextField extends ValidatorField {
  @override
  String? validate(String? value) => null;
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

/// Optional/required numeric field validation with configurable min/max bounds.
final class ValidatorNumericRangeTextField extends ValidatorField {
  ValidatorNumericRangeTextField({
    this.min,
    this.max,
    this.isOptional = false,
  });

  final int? min;
  final int? max;
  final bool isOptional;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isOptional ? null : LocaleKeys.validation_requiredField.tr();
    }

    final number = int.tryParse(value.trim());
    if (number == null) return LocaleKeys.validation_numericInvalid.tr();

    if (min != null && number < min!) {
      return _rangeMessage();
    }

    if (max != null && number > max!) {
      return _rangeMessage();
    }

    return null;
  }

  String _rangeMessage() {
    if (min != null && max != null) {
      return LocaleKeys.validation_numericRange.tr(args: ['$min', '$max']);
    }
    if (min != null) {
      return LocaleKeys.validation_numericMin.tr(args: ['$min']);
    }
    if (max != null) {
      return LocaleKeys.validation_numericMax.tr(args: ['$max']);
    }
    return LocaleKeys.validation_numericInvalid.tr();
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
    if (value.ext.phoneFormatValue.ext.isNullOrEmpty ||
        value.ext.phoneFormatValue.length < AppConstants.kTen) {
      return LocaleKeys.validation_phoneNumber.tr();
    }
    return null;
  }
}

final class ValidateCloseDate extends ValidatorField {
  ValidateCloseDate({required this.controller});

  final TimePickerController controller;
  @override
  String? validate(String? value) {
    if (value.ext.isNullOrEmpty) {
      return LocaleKeys.validation_pickATime.tr();
    }
    final openTime = controller.time;
    if (openTime == null) return LocaleKeys.validation_pickATime.tr();
    return null;
  }
}

final class DropdownModelValidate extends ValidatorField {
  @override
  String? validateDropDownField(BaseDropDownModel? value) {
    if (value == null) {
      return LocaleKeys.validation_requiredField.tr();
    }
    return null;
  }
}
