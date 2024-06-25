part of '../general_dotted_photo_add.dart';

extension _GeneralDottedPhotoAddContextExtension on BuildContext {
  GeneralDottedPhotoAddProviderState get generalDottedPhotoAddContext {
    return GeneralDottedPhotoAddContext.of(this);
  }
}
