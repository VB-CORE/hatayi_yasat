import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/social/memory_model.dart';
import 'package:lifeclient/product/repository/_auth_session.dart';
import 'package:lifeclient/product/repository/memories/memory_input.dart';

/// Memories ("Hatıralar") repository — Firestore at `memories/`.
@immutable
final class MemoriesRepository {
  MemoriesRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('memories');

  Stream<List<MemoryModel>> watchMemories({
    required String cityId,
    int limit = 50,
  }) {
    return _col
        .where('cityId', isEqualTo: cityId)
        .where('status', isEqualTo: MemoryStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(_mapDocs);
  }

  Stream<List<MemoryModel>> watchByUser(String uid, {int limit = 50}) {
    return _col
        .where('authorUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(_mapDocs);
  }

  Future<MemoryModel?> get(String id) async {
    final snap = await _col.doc(id).get();
    final data = snap.data();
    if (data == null) return null;
    return MemoryModel.fromJson(snap.id, data);
  }

  Future<String> create(CreateMemoryInput input) async {
    final uid = currentUid;
    final docRef = _col.doc();
    final photoUrls = <String>[];
    for (var i = 0; i < input.photoFiles.length; i++) {
      final ref = _storage.ref('pending/memories/$uid/${docRef.id}/$i.jpg');
      await ref.putFile(input.photoFiles[i]);
      photoUrls.add(await ref.getDownloadURL());
    }
    await docRef.set({
      'authorUid': uid,
      'authorName': currentDisplayName,
      'cityId': input.cityId,
      'title': input.title,
      'text': input.text,
      'year': input.year,
      'era': input.era,
      'neighborhood': input.neighborhood,
      'photos': photoUrls,
      'loveCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'status': MemoryStatus.approved.name,
    });
    return docRef.id;
  }

  Future<void> love(String memoryId) async {
    final uid = currentUid;
    final loveRef = _firestore
        .collection('memory_loves')
        .doc('${memoryId}_$uid');
    final memRef = _col.doc(memoryId);
    await _firestore.runTransaction((txn) async {
      final existing = await txn.get(loveRef);
      if (existing.exists) return;
      txn
        ..set(loveRef, {
          'memoryId': memoryId,
          'uid': uid,
          'createdAt': FieldValue.serverTimestamp(),
        })
        ..update(memRef, {'loveCount': FieldValue.increment(1)});
    });
  }

  List<MemoryModel> _mapDocs(QuerySnapshot<Map<String, dynamic>> snap) {
    return snap.docs
        .map((d) => MemoryModel.fromJson(d.id, d.data()))
        .toList(growable: false);
  }
}
