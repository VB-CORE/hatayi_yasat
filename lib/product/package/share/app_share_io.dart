import 'dart:typed_data';

import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/feature/path_operation/custom_path_manager.dart';
import 'package:lifeclient/product/package/share/app_share.dart';
import 'package:share_plus/share_plus.dart';

final class PlatformAppShare implements AppShare {
  const PlatformAppShare();

  @override
  Future<void> shareText(String text) => text.ext.share();

  @override
  Future<XFile?> toShareFile(Uint8List bytes, String fileName) async {
    final file = await CustomPathManager().writeByteToFile(bytes, fileName);
    if (file == null) return null;
    return XFile(file.path);
  }
}
