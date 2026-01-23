import 'package:easy_localization/easy_localization.dart';
import 'package:life_shared/life_shared.dart';
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
}
