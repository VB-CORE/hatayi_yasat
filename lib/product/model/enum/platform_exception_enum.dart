// ignore_for_file: sort_constructors_first

import 'package:collection/collection.dart';

enum PlatformExceptionEnum {
  photoAccessDenied('photo_access_denied'),
  cameraAccessDenied('camera_access_denied'),
  ;

  final String value;
  const PlatformExceptionEnum(this.value);

  static PlatformExceptionEnum? fromValue(String? value) {
    if (value == null) return null;
    return PlatformExceptionEnum.values.firstWhereOrNull(
      (element) => element.value == value,
    );
  }
}
