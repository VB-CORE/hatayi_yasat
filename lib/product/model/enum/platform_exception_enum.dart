import 'package:collection/collection.dart';

enum PlatformExceptionEnum {
  photoAccessDenied('photo_access_denied'),
  cameraAccessDenied('camera_access_denied'),
  ;

  const PlatformExceptionEnum(this.value);
  final String value;

  static PlatformExceptionEnum? fromValue(String? value) {
    if (value == null) return null;
    return PlatformExceptionEnum.values.firstWhereOrNull(
      (element) => element.value == value,
    );
  }
}
