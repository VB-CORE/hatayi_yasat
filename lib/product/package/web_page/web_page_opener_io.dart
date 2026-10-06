import 'package:flutter/material.dart';
import 'package:lifeclient/product/package/web_page/web_page_opener.dart';
import 'package:lifeclient/product/widget/sheet/in_app_web_page_sheet.dart';

final class PlatformWebPageOpener implements WebPageOpener {
  const PlatformWebPageOpener();

  @override
  Future<void> open(BuildContext context, String url) {
    return showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => InAppWebPageSheet(url: url),
    );
  }
}
