import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/repository/_auth_session.dart';

/// Favourites are sub-collections under `favorites/{uid}/{kind}/{id}`.
/// `kind` is one of `places`, `posts`, `memories`. Each doc is a thin
/// presence record carrying the saved-at timestamp.
@immutable
final class FavoritesRepository {
  FavoritesRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _kindCol(
    String uid,
    FavoriteKind kind,
  ) => _firestore.collection('favorites').doc(uid).collection(kind.name);

  Stream<List<String>> watchIds(FavoriteKind kind) {
    return _kindCol(currentUid, kind)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.id).toList(growable: false));
  }

  Future<void> add(FavoriteKind kind, String id) async {
    await _kindCol(currentUid, kind).doc(id).set({
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> remove(FavoriteKind kind, String id) async {
    await _kindCol(currentUid, kind).doc(id).delete();
  }

  Future<bool> exists(FavoriteKind kind, String id) async {
    final snap = await _kindCol(currentUid, kind).doc(id).get();
    return snap.exists;
  }
}

enum FavoriteKind { places, posts, memories }
