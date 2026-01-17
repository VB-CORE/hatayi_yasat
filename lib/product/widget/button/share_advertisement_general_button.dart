import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:share_plus/share_plus.dart';

final class ShareAdvertisementGeneralButton extends StatelessWidget {
  const ShareAdvertisementGeneralButton({
    required this.description,
    required this.url,
    required this.owner,
    super.key,
  });

  final String url;
  final String description;
  final String owner;

  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.active(
      label: LocaleKeys.button_share.tr(),
      action: () async => _onPressed(),
    );
  }

  Future<void> _onPressed() async {
    await SharePlus.instance.share(
      ShareParams(
        text: _getText,
        subject: LocaleKeys.advertisementBoard_shareAdvertisementSubject.tr(
          args: [owner],
        ),
      ),
    );
  }

  String get _getText {
    if (description.isNotEmpty && url.isNotEmpty) {
      return ' $description\n$url';
    }

    return url.isEmpty ? description : url;
  }
}
