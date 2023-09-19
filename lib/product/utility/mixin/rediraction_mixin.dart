import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/dialog/approve_dialog.dart';

import 'package:vbaseproject/product/utility/constants/regex_types.dart';

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
    if (Platform.isIOS) {
      await _searchOnGoogleMaps(placeAddress);
    }
    await '${AppConstants.googleMapsPlaceLink}$placeAddress'.ext.launchWebsite;
  }

  static Future<void> _searchOnGoogleMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(
      query,
    );
    final googleMapsUrl = '${AppConstants.googleMapsUrl}$encodedQuery';
    final googleMapsWebUrl = '${AppConstants.googleMapsPlaceLink}$encodedQuery';

    try {
      final response = await googleMapsUrl.ext.launchWebsite;
      if (response) return;
    } catch (_) {}
    await googleMapsWebUrl.ext.launchWebsiteCustom();
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
    final cleanPhoneNumber =
        phoneNumber.replaceAll(RegexTypes.phoneNumberRegex, '');

    await cleanPhoneNumber.ext.launchPhone;
  }
}
