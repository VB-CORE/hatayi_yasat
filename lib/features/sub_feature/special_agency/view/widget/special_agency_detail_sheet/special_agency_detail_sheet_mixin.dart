part of './special_agency_detail_sheet.dart';

mixin _SpecialAgencyDetailSheetMixin {
  Future<void> onPhoneClick(BuildContext context, String? phone) async {
    if (phone.ext.isNullOrEmpty) return;
    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: phone ?? '',
    );
  }

  Future<void> onLocationClick(BuildContext context, GeoPoint latLong) async {
    final latLongString = '${latLong.latitude},${latLong.longitude}';
    await RedirectionMixin.navigateToMapsWithTitle(
      context: context,
      placeAddress: latLongString,
    );
  }
}
