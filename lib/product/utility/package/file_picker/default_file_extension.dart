import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/package/file_picker/file_extension_enum.dart';

@immutable
final class DefaultFileExtension {
  const DefaultFileExtension._();

  static const List<FileExtensionEnum> documentExtensionList = [
    FileExtensionEnum.pdf,
    FileExtensionEnum.doc,
    FileExtensionEnum.docx,
  ];
}
