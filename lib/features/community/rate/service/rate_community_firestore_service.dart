import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/service/rate_community_service.dart';

final class RateCommunityFirestoreService implements RateCommunityService {
  RateCommunityFirestoreService({
    FirebaseFirestore? firestore,
    this.timeoutDuration = const Duration(seconds: 10),
    this.fetchLimit = 20,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final Duration timeoutDuration;
  final int fetchLimit;

  static const String _storesPath = 'approvedApplications';
  static const String _votesPath = 'votes';
  static const String _createdAtField = 'createdAt';

  CollectionReference<Map<String, dynamic>> _votes(String placeId) =>
      _firestore.collection(_storesPath).doc(placeId).collection(_votesPath);

  @override
  Future<List<RateModel>> fetchRates(String placeId) async {
    try {
      final snapshot = await _votes(placeId)
          .orderBy(_createdAtField, descending: true)
          .limit(fetchLimit)
          .get()
          .timeout(timeoutDuration);
      return snapshot.docs.map(RateModel.fromFirestore).toList();
    } on FirebaseException catch (error) {
      ProductLogger.log('fetchRates($placeId) ${error.code} ${error.message}');
      return [];
    } on TimeoutException catch (error) {
      ProductLogger.log('fetchRates($placeId) $error');
      return [];
    }
  }

  @override
  Future<RateModel?> fetchMyRate(String placeId, String voterUid) async {
    try {
      final doc = await _votes(
        placeId,
      ).doc(voterUid).get().timeout(timeoutDuration);
      if (!doc.exists) return null;
      return RateModel.fromFirestore(doc);
    } on FirebaseException catch (error) {
      ProductLogger.log(
        'fetchMyRate($voterUid) ${error.code} ${error.message}',
      );
      return null;
    } on TimeoutException catch (error) {
      ProductLogger.log('fetchMyRate($voterUid) $error');
      return null;
    }
  }

  @override
  Future<bool> rate(RateModel rate) async {
    try {
      await _votes(
        rate.placeId,
      ).doc(rate.voterUid).set(rate.toJson());
      return true;
    } on FirebaseException catch (error) {
      ProductLogger.log(
        'rate(${rate.voterUid}) ${error.code} ${error.message}',
      );
      return false;
    }
  }

  @override
  Future<bool> changeComment(RateModel rate) async {
    try {
      await _votes(rate.placeId).doc(rate.voterUid).update({
        'comment': rate.comment,
        'updatedAt': Timestamp.fromDate(rate.updatedAt),
      });
      return true;
    } on FirebaseException catch (error) {
      ProductLogger.log(
        'changeComment(${rate.voterUid}) ${error.code} ${error.message}',
      );
      return false;
    }
  }

  @override
  Future<bool> deleteRate(RateModel rate) async {
    try {
      await _votes(
        rate.placeId,
      ).doc(rate.voterUid).delete();
      return true;
    } on FirebaseException catch (error) {
      ProductLogger.log(
        'deleteRate(${rate.voterUid}) ${error.code} ${error.message}',
      );
      return false;
    }
  }
}
