import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

extension StoreModelExtension on StoreModel {
  static const String visitCountField = 'visitCount';

  String get updatedName => name.ext.toTitleCase();

  String? get coverImage => images.firstOrNull;

  bool get hasImage => coverImage.ext.isNotNullOrNoEmpty;

  bool get hasDescription => description.ext.isNotNullOrNoEmpty;

  bool get hasOwner => owner.ext.isNotNullOrNoEmpty;

  bool get hasPhone => phone.ext.isNotNullOrNoEmpty;

  bool get hasAddress => address.ext.isNotNullOrNoEmpty;

  bool get hasMap => hasAddress && latLong != null;

  bool get hasContactInfo => hasPhone || hasAddress || hasMap;
 

  static Map<String, Object?> updateFields({
    String? name,
    String? description,
    String? phone,
    String? address,
    CategoryModel? category,
    bool? isCommentEnabled,
    List<String>? images,
    String? openTime,
    String? closeTime,
    bool clearOpenTime = false,
    bool clearCloseTime = false,
  }) => {
    'name': ?name,
    'description': ?description,
    'phone': ?phone,
    'address': ?address,
    'category': ?category?.toJson(),
    'isCommentEnabled': ?isCommentEnabled,
    'images': ?images,
    if (clearOpenTime) 'openTime': null else 'openTime': ?openTime,
    if (clearCloseTime) 'closeTime': null else 'closeTime': ?closeTime,
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
