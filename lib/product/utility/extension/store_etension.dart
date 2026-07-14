import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

extension StoreModelExtension on StoreModel {
  String get updatedName => name.ext.toTitleCase();

  String? get coverImage => images.firstOrNull;

  bool get hasImage => coverImage.ext.isNotNullOrNoEmpty;

  bool get hasDescription => description.ext.isNotNullOrNoEmpty;

  bool get hasOwner => owner.ext.isNotNullOrNoEmpty;

  bool get hasPhone => phone.ext.isNotNullOrNoEmpty;

  bool get hasAddress => address.ext.isNotNullOrNoEmpty;

  bool get hasMap => hasAddress && latLong != null;

  bool get hasContactInfo => hasPhone || hasAddress || hasMap;
}
