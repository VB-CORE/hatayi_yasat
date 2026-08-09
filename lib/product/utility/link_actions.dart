import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/snack_bar/app_toast.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class LinkActions {
  static Future<void> call(BuildContext context, String? phone) async {
    if (phone == null || phone.isEmpty) return;

    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: phone,
    );
  }

  static Future<void> directions(BuildContext context, String? address) async {
    if (address == null || address.isEmpty) return;

    await RedirectionMixin.navigateToMapsWithTitle(
      context: context,
      placeAddress: address,
    );
  }

  static Future<void> openUrl(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.tryParse(url.trim());
    if (uri == null) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> copy(BuildContext context, String? value) async {
    if (value == null || value.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;

    AppToast.show(context, LocaleKeys.general_toast_copied);
  }
}
