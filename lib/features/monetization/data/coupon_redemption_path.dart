import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class CouponRedemptionPath extends Equatable
    implements FirestoreCollectionPath {
  const CouponRedemptionPath(this.couponId);

  static const String childName = 'redemptions';

  final String couponId;

  @override
  CollectionReference<Map<String, dynamic>> get collection =>
      CollectionPaths.coupons.collection.doc(couponId).collection(childName);

  @override
  String get path => '${CollectionPaths.coupons.path}/$couponId/$childName';

  @override
  List<Object?> get props => [couponId];
}
