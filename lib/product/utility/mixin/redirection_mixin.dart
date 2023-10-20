import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/regex_types.dart';
import 'package:vbaseproject/product/widget/dialog/approve_dialog.dart';

mixin RedirectionMixin {
  static Future<void> navigateToMapsWithTitle({
    required BuildContext context,
    required String placeAddress,
  }) async {
    final response = await ApproveDialog.show(
      context: context,
      title: LocaleKeys.dialog_addressTitle,
    );
    if (response == null || !response) return;

    await placeAddress.ext.launchMaps();
  }

  static Future<void> openToPhone({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    final response = await ApproveDialog.show(
      context: context,
      title: LocaleKeys.dialog_phoneTitle,
    );
    if (response == null || !response) return;
    var cleanPhoneNumber =
        phoneNumber.replaceAll(RegexTypes.phoneNumberRegex, '');

    if (!cleanPhoneNumber.startsWith('0')) {
      cleanPhoneNumber = '0$cleanPhoneNumber';
    }

    await cleanPhoneNumber.ext.launchPhone;
  }
}
