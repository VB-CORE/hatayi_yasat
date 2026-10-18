import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/index.dart';

final class InAppWebPageSheet extends StatefulWidget {
  const InAppWebPageSheet({required this.url, super.key});

  final String url;

  @override
  State<InAppWebPageSheet> createState() => _InAppWebPageSheetState();
}

class _InAppWebPageSheetState extends State<InAppWebPageSheet> {
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
                  urlRequest: URLRequest(url: WebUri(widget.url)),
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
