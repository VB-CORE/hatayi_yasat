import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:url_launcher/url_launcher.dart';

final class OpenUrlGeneralButton extends StatelessWidget {
  const OpenUrlGeneralButton({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.active(
      action: () async => _onPressed(context),
      label: LocaleKeys.advertisementBoard_openUrl.tr(),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    var isLaunched = false;

    try {
      isLaunched = await launchUrl(Uri.parse(url));
    } catch (_) {
      isLaunched = false;
    }

    if (isLaunched || !context.mounted) {
      return;
    }

    await _showErrorDialog(context);
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    await GeneralTextDialog.show(
      context,
      LocaleKeys.button_error,
      LocaleKeys.advertisementBoard_launchUrlError,
      [
        GeneralDialogButton(
          onPressed: () => Navigator.pop(context),
          title: LocaleKeys.button_ok,
        ),
      ],
    );
  }
}
