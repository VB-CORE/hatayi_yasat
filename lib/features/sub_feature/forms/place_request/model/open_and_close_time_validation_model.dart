import 'package:flutter/material.dart';

final class OpenAndCloseTimeValidationModel {
  const OpenAndCloseTimeValidationModel({
    this.openTime,
    this.closeTime,
  });

  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  bool get isValid =>
      (openTime != null && closeTime != null) &&
      (openTime!.hour < closeTime!.hour);

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
