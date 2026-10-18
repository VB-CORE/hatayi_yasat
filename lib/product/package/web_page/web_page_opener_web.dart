import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/package/web_page/web_page_opener.dart';
import 'package:url_launcher/url_launcher.dart';

final class PlatformWebPageOpener implements WebPageOpener {
  const PlatformWebPageOpener();

  @override
  Future<void> open(BuildContext context, String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }
}
