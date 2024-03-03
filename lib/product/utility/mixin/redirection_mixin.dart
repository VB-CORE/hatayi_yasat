import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/utility/maps_utility.dart';
import 'package:lifeclient/product/utility/constants/regex_types.dart';

mixin RedirectionMixin {
  static Future<void> navigateToMapsWithTitle({
    required BuildContext context,
    required String placeAddress,
  }) async {
    final query = placeAddress;
    if (query.ext.isNullOrEmpty) return;

    /// first of all check if google maps is installed
    /// TODO: add kartal
    final encodedQuery = Uri.encodeComponent(query);
    final result = await MapsUtility.openGoogleMapsWithQuery(encodedQuery);
    if (result) return;
    await placeAddress.ext.launchMaps();
  }

  static Future<void> openToPhone({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    var cleanPhoneNumber =
        phoneNumber.replaceAll(RegexTypes.phoneNumberRegex, '');

    if (!cleanPhoneNumber.startsWith('0')) {
      cleanPhoneNumber = '0$cleanPhoneNumber';
    }

    await cleanPhoneNumber.ext.launchPhone;
  }
}
