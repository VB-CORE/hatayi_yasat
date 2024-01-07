import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

final class AppAboutView extends StatefulWidget {
  const AppAboutView({super.key});
  @override
  State<AppAboutView> createState() => _AppAboutViewState();
}

class _AppAboutViewState extends State<AppAboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_aboutTitle.tr(),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(AppConstants.homeWebsiteUrl)),
      ),
    );
  }
}
