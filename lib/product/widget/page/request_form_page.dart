import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/general_button.dart';
import 'package:vbaseproject/product/widget/list_view/list_view_with_space.dart';

@immutable
final class RequestFormPage extends StatelessWidget {
  const RequestFormPage({
    required this.title,
    required this.onSendButtonTapped,
    required this.children,
    required this.sendButtonLabel,
    super.key,
  });

  final String title;
  final String sendButtonLabel;
  final AsyncCallback onSendButtonTapped;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: _RequestFormBottomButton(
        buttonTitle: sendButtonLabel,
        onTapped: onSendButtonTapped,
      ),
      body: ListViewWithSpace(
        children: children,
      ),
    );
  }
}

@immutable
final class _RequestFormBottomButton extends StatelessWidget {
  const _RequestFormBottomButton({
    required this.buttonTitle,
    required this.onTapped,
  });
  final String buttonTitle;
  final AsyncCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralButtonV2.async(
              action: onTapped,
              label: buttonTitle,
            ),
          ],
        ),
      ),
    );
  }
}
