import 'dart:io';

import 'package:life_shared/life_shared.dart';

extension FileSizeX on File {
  /// Yükleme boyut sınırını (1 MB) aşıyor mu — storage kuralıyla aynı eşik.
  bool get exceedsUploadLimit => lengthSync() > FileSizes.large.toByte;
}
