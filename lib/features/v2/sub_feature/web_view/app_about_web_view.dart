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
  int progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_aboutTitle.tr(),
        ),
      ),
      body: Stack(
        children: [
          _LoadingWidget(progress),
          InAppWebView(
            onProgressChanged: (controller, progress) {
              this.progress = progress;
            },
            initialUrlRequest:
                URLRequest(url: WebUri(AppConstants.homeWebsiteUrl)),
          ),
        ],
      ),
    );
  }
}

final class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget(this.progress);

  final int progress;

  @override
  Widget build(BuildContext context) {
    return progress != 100
        ? const Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          )
        : const SizedBox.shrink();
  }
}
