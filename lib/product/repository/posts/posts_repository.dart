import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/social/post_model.dart';
import 'package:lifeclient/product/repository/_auth_session.dart';
import 'package:lifeclient/product/repository/posts/post_input.dart';

/// Posts repository — talks directly to Firestore at `posts/`.
///
/// The collection does not exist in the database yet; the first call to
/// [create] will materialise it. Photos go to Storage at
/// `pending/posts/{uid}/{postId}/{i}.jpg`. See `docs/backend_plan.md`
/// for the schema and rules to add. This class is designed to be lifted
/// into the `life_shared` package later — keep the API surface stable.
@immutable
final class PostsRepository {
  PostsRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('posts');

  /// Newest-first feed, optionally scoped to a city. Pagination is left
  /// for follow-up; the design ships without infinite scroll.
  Stream<List<PostModel>> watchFeed({
    required String cityId,
    int limit = 50,
  }) {
    return _col
        .where('cityId', isEqualTo: cityId)
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(_mapDocs);
  }

  /// All posts authored by [uid] — used by Profile "Paylaşımlar".
  Stream<List<PostModel>> watchByUser(String uid, {int limit = 50}) {
    return _col
        .where('authorUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(_mapDocs);
  }

  /// Posts mentioning a specific place — used by Place Detail
  /// "Bahsedilenler" tab.
  Stream<List<PostModel>> watchForPlace(String placeId, {int limit = 50}) {
    return _col
        .where('placeId', isEqualTo: placeId)
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(_mapDocs);
  }

  /// One-shot single post fetch — used by Post Detail when navigated
  /// without an `$extra`.
  Future<PostModel?> get(String id) async {
    final snap = await _col.doc(id).get();
    final data = snap.data();
    if (data == null) return null;
    return PostModel.fromJson(snap.id, data);
  }

  /// Create a post. Uploads photos first so the Firestore doc references
  /// permanent URLs. Returns the new doc id.
  Future<String> create(CreatePostInput input) async {
    final uid = currentUid;
    final docRef = _col.doc();
    final photoUrls = <String>[];
    for (var i = 0; i < input.photoFiles.length; i++) {
      final ref = _storage.ref(
        'pending/posts/$uid/${docRef.id}/$i.jpg',
      );
      await ref.putFile(input.photoFiles[i]);
      photoUrls.add(await ref.getDownloadURL());
    }
    await docRef.set({
      'authorUid': uid,
      'authorName': currentDisplayName,
      'authorAvatarColor': currentAvatarColor,
      'cityId': input.cityId,
      'text': input.text,
      'photos': photoUrls,
      'placeId': input.placeId,
      'placeName': input.placeName,
      'placeDistrict': input.placeDistrict,
      'isMemory': input.isMemory,
      'year': input.year,
      'likeCount': 0,
      'commentCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'status': PostStatus.approved.name,
    });
    return docRef.id;
  }

  /// Toggle like for [postId]. Idempotent — the presence doc at
  /// `post_likes/{postId}_{uid}` and the `likeCount` are kept in sync
  /// via a transaction so concurrent likes don't double-count.
  Future<void> like(String postId) async {
    final uid = currentUid;
    final likeRef = _firestore.collection('post_likes').doc('${postId}_$uid');
    final postRef = _col.doc(postId);
    await _firestore.runTransaction((txn) async {
      final existing = await txn.get(likeRef);
      if (existing.exists) return;
      txn
        ..set(likeRef, {
          'postId': postId,
          'uid': uid,
          'kind': 'like',
          'createdAt': FieldValue.serverTimestamp(),
        })
        ..update(postRef, {'likeCount': FieldValue.increment(1)});
    });
  }

  Future<void> unlike(String postId) async {
    final uid = currentUid;
    final likeRef = _firestore.collection('post_likes').doc('${postId}_$uid');
    final postRef = _col.doc(postId);
    await _firestore.runTransaction((txn) async {
      final existing = await txn.get(likeRef);
      if (!existing.exists) return;
      txn
        ..delete(likeRef)
        ..update(postRef, {'likeCount': FieldValue.increment(-1)});
    });
  }

  /// Whether [uid] has liked [postId]. Used to colour the heart on the
  /// post detail header.
  Stream<bool> watchIsLiked(String postId) {
    final uid = currentUid;
    return _firestore
        .collection('post_likes')
        .doc('${postId}_$uid')
        .snapshots()
        .map((d) => d.exists);
  }

  List<PostModel> _mapDocs(QuerySnapshot<Map<String, dynamic>> snap) {
    return snap.docs
        .map((d) => PostModel.fromJson(d.id, d.data()))
        .toList(growable: false);
  }
}
