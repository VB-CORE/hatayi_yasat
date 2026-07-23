import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@Deprecated(
  'Use FirestoreService through ProjectDependencyMixin.firestoreService, it '
  'returns FirestoreResult so timeout, permission and parse errors are no '
  'longer swallowed',
)
@immutable
final class FirebaseCustomService extends FirebaseService {
  /// getit inject
  @Deprecated('Use FirestoreService')
  FirebaseCustomService() : super();
}
