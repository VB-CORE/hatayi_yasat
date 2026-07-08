import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/path_operation/custom_path_manager.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';

final class CustomShare {
  const CustomShare._();

  static Future<void> shareMemory(MemoryModel memory) async {
    final firstImageUrl = memory.imageUrls?.firstOrNull ?? '';
    if (firstImageUrl.isEmpty) {
      return;
    }
    await SharePlus.instance.share(
      ShareParams(
        text: firstImageUrl,
        subject: LocaleKeys.historyPage_shareSubject.tr(),
      ),
    );
  }

  static Future<void> shareImage(
    BuildContext context, {
    required Uint8List bytes,
    required String fileName,
    String? subject,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final sharePositionOrigin = box.localToGlobal(Offset.zero) & box.size;
    final file = await CustomPathManager().writeByteToFile(bytes, fileName);
    if (file == null) return;

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      ),
    );
  }
}
