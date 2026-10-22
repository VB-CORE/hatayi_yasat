import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

abstract interface class AppShare {
  Future<void> shareText(String text);

  Future<XFile?> toShareFile(Uint8List bytes, String fileName);
}
