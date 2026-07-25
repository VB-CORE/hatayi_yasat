import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/firestore/custom_batch_service.dart';

@immutable
final class BatchService extends CustomBatchService {
  const BatchService({super.timeoutDuration});

  @override
  Future<FirestoreResult<bool>> commit(void Function(WriteBatch batch) build) {
    return _guard(() async {
      final batch = FirebaseFirestore.instance.batch();
      build(batch);
      await batch.commit();
      return true;
    });
  }

  Future<FirestoreResult<bool>> _guard(Future<bool> Function() request) async {
    try {
      return FirebaseSuccess(await request().timeout(timeoutDuration));
    } on TimeoutException {
      return const FirebaseFailure(FirestoreError.timeout);
    } on FirebaseException catch (error) {
      return FirebaseFailure(
        FirestoreError.fromCode(error.code),
        message: error.message,
      );
    } catch (error) {
      return FirebaseFailure(FirestoreError.unknown, message: '$error');
    }
  }
}
