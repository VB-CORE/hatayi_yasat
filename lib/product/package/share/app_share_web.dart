import 'dart:typed_data';

import 'package:lifeclient/product/package/share/app_share.dart';
import 'package:share_plus/share_plus.dart';

final class PlatformAppShare implements AppShare {
  const PlatformAppShare();

  @override
  Future<void> shareText(String text) =>
      SharePlus.instance.share(ShareParams(text: text));

  @override
  Future<XFile?> toShareFile(Uint8List bytes, String fileName) async =>
      XFile.fromData(bytes, name: fileName);
}
