import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/index.dart';

final class AppAboutView extends StatefulWidget {
  const AppAboutView({super.key});
  @override
  State<AppAboutView> createState() => _AppAboutViewState();
}

class _AppAboutViewState extends State<AppAboutView> {
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.8),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(AppIcons.back),
        ),
        body: Stack(
          children: [
            InAppWebView(
              onWebViewCreated: (controller) async {
                await controller.loadUrl(
                  urlRequest:
                      URLRequest(url: WebUri(AppConstants.homeWebsiteUrl)),
                );
                _isLoadingNotifier.value = false;
              },
            ),
            ValueListenableBuilder(
              valueListenable: _isLoadingNotifier,
              builder: (context, value, child) {
                if (!value) return const SizedBox();
                return const _LoadingWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}

final class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
