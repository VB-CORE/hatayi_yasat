import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
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
    if (Platform.isIOS) {
      await _searchOnAppleMaps(placeAddress);
    }
    await _searchOnGoogleMaps(placeAddress);
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

  static Future<void> _searchOnAppleMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(
      query,
    );
    final appleMapsUrl = '${AppConstants.appleMapsUrl}$encodedQuery';
    final googleMapsWebUrl = '${AppConstants.googleMapsPlaceLink}$encodedQuery';

    try {
      final response = await appleMapsUrl.ext.launchWebsite;
      if (response) return;
    } catch (_) {}
    await googleMapsWebUrl.ext.launchWebsiteCustom();
  }

  static Future<void> _searchOnGoogleMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(
      query,
    );
    final googleMapsUrl = '${AppConstants.googleMapsUrl}=$encodedQuery';
    final googleMapsWebUrl = '${AppConstants.googleMapsPlaceLink}$encodedQuery';

    try {
      final response = await googleMapsUrl.ext.launchWebsite;
      if (response) return;
    } catch (_) {}
    await googleMapsWebUrl.ext.launchWebsiteCustom();
  }
}
