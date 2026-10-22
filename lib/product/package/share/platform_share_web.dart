import 'dart:typed_data';

import 'package:lifeclient/product/package/share/platform_share.dart';
import 'package:share_plus/share_plus.dart';

final class PlatformShare implements FileShare {
  const PlatformShare();

  @override
  Future<void> shareText(String text) =>
      SharePlus.instance.share(ShareParams(text: text));

  @override
  Future<XFile?> toShareFile(Uint8List bytes, String fileName) async =>
      XFile.fromData(bytes, name: fileName);
}
