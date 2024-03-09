import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/chain_store/view/chain_store_view.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';

mixin ChainStoreViewModel on ConsumerState<ChainStoreView> {
  Future<void> launchMapWithLatLong(
    BuildContext context,
    GeoPoint locationPoint,
  ) async {
    final latitude = locationPoint.latitude;
    final longitude = locationPoint.longitude;
    final latLongString = '$latitude,$longitude';
    await RedirectionMixin.navigateToMapsWithTitle(
      context: context,
      placeAddress: latLongString,
    );
  }

  Future<void> launchPhoneWithPhoneNumber(
    BuildContext context,
    String phoneNumber,
  ) async {
    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: phoneNumber,
    );
  }
}
