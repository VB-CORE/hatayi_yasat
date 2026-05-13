import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/social/merchant_application_model.dart';
import 'package:lifeclient/product/repository/_auth_session.dart';
import 'package:lifeclient/product/repository/merchant/merchant_application_input.dart';

@immutable
final class MerchantApplicationRepository {
  MerchantApplicationRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('merchant_applications');

  /// Most recent application for [uid], or null if none exist.
  Future<MerchantApplicationModel?> getMyApplication(String uid) async {
    final snap = await _col
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    return MerchantApplicationModel.fromJson(doc.id, doc.data());
  }

  Stream<MerchantApplicationStatus> watchStatus(String uid) {
    return _col
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .map((s) {
          if (s.docs.isEmpty) return MerchantApplicationStatus.none;
          return MerchantApplicationStatus.fromString(
            s.docs.first.data()['status'] as String?,
          );
        });
  }

  Future<String> submit(MerchantApplicationInput input) async {
    final uid = currentUid;
    final docRef = _col.doc();
    final photoUrls = await _uploadAll(
      input.photoFiles,
      'pending/merchant/$uid/${docRef.id}/photos',
    );
    final docUrls = await _uploadAll(
      input.documentFiles,
      'pending/merchant/$uid/${docRef.id}/documents',
    );
    final now = DateTime.now();
    await docRef.set({
      'uid': uid,
      'placeName': input.placeName,
      'placeCategory': input.placeCategory,
      'description': input.description,
      'photos': photoUrls,
      'phone': input.phone,
      'address': input.address,
      'location': input.location,
      'hours': input.hours,
      'ownerName': input.ownerName,
      'taxNumber': input.taxNumber,
      'registryNumber': input.registryNumber,
      'documents': docUrls,
      'status': MerchantApplicationStatus.submitted.firestoreValue,
      'timeline': [
        {
          'stage': MerchantApplicationStatus.submitted.firestoreValue,
          'at': Timestamp.fromDate(now),
        },
      ],
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  Future<List<String>> _uploadAll(List<File> files, String prefix) async {
    final urls = <String>[];
    for (var i = 0; i < files.length; i++) {
      final ref = _storage.ref('$prefix/$i.jpg');
      await ref.putFile(files[i]);
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }
}
