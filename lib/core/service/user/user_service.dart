import 'package:life_shared/life_shared.dart';

abstract interface class UserService {
  Future<bool> update({String? displayName, int? avatarType});

  /// Moves one of the display counters on the caller's own user document.
  Future<bool> stepCounter(UserCounterFields counter, {int by = 1});
}
