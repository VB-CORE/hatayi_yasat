import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class FirebaseCustomService extends FirebaseService {
  /// getit inject
  FirebaseCustomService() : super(timeoutDuration: const Duration(seconds: 1));
}
