import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/social/review_model.dart';
import 'package:lifeclient/product/repository/_auth_session.dart';
import 'package:lifeclient/product/repository/reviews/review_input.dart';

@immutable
final class ReviewsRepository {
  ReviewsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('reviews');

  Stream<List<ReviewModel>> watchForPlace(String placeId) {
    return _col
        .where('placeId', isEqualTo: placeId)
        .where('status', isEqualTo: ReviewStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_mapDocs);
  }

  Future<String> submit(CreateReviewInput input) async {
    final uid = currentUid;
    final docRef = _col.doc();
    await docRef.set({
      'placeId': input.placeId,
      'authorUid': uid,
      'authorName': input.anonymous ? '' : currentDisplayName,
      'anonymous': input.anonymous,
      'rating': input.rating,
      'text': input.text,
      'createdAt': FieldValue.serverTimestamp(),
      'status': ReviewStatus.approved.name,
    });
    return docRef.id;
  }

  List<ReviewModel> _mapDocs(QuerySnapshot<Map<String, dynamic>> snap) {
    return snap.docs
        .map((d) => ReviewModel.fromJson(d.id, d.data()))
        .toList(growable: false);
  }
}
