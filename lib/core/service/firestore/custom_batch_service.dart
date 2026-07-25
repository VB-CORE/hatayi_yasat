import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';

abstract class CustomBatchService {
  const CustomBatchService({
    this.timeoutDuration = const Duration(seconds: 10),
  });

  final Duration timeoutDuration;

  Future<FirestoreResult<bool>> commit(void Function(WriteBatch batch) build);
}
