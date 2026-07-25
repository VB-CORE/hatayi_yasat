import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';

/// Birden fazla yazmayı tek atomik batch'te commit eder. Her çağrı bir
/// [FirestoreResult] döner; çağıran gerçek hatayı (rules/ağ) başarıdan ayırır.
///
/// life_shared'ın `CustomFirestoreService` deseniyle aynı yapı — batch desteği
/// shared'a eklendiğinde bu servis oraya taşınabilir.
abstract class CustomBatchService {
  const CustomBatchService({
    this.timeoutDuration = const Duration(seconds: 10),
  });

  final Duration timeoutDuration;

  /// [build] verilen [WriteBatch]'e yazma işlemlerini ekler; servis commit eder.
  Future<FirestoreResult<bool>> commit(void Function(WriteBatch batch) build);
}
