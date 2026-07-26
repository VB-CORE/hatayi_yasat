import 'dart:io';

import 'package:life_shared/life_shared.dart';

extension FileSizeX on File {
  Future<bool> get exceedsUploadLimit async =>
      await length() > uploadLimit.toByte;

  static const FileSizes uploadLimit = FileSizes.large;

  static String get uploadLimitLabel => '${uploadLimit.kbValue ~/ 1000}';
}
