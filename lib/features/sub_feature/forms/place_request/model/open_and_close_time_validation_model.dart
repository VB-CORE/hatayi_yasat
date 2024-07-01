import 'package:flutter/material.dart';

final class OpenAndCloseTimeValidationModel {
  const OpenAndCloseTimeValidationModel({
    this.openTime,
    this.closeTime,
  });

  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  bool get isValid {
    if (openTime == null || closeTime == null) return false;

    if (openTime!.hour == closeTime!.hour) return false;

    return true;
  }

  bool get isNotValid => !isValid;

  OpenAndCloseTimeValidationModel copyWith({
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
  }) {
    return OpenAndCloseTimeValidationModel(
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }
}
