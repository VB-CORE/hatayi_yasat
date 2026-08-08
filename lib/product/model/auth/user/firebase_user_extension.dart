import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/auth/user/avatar_types.dart';

/// Bridges `firebase_auth` to [UserModel]. Lives here because life_shared has
/// no auth dependency, and avatars are bound to this app's assets.
extension FirebaseUserExtension on User {
  /// [displayNameOverride] carries the name Apple only ever returns on the
  /// first authorization; Firebase itself leaves [displayName] null for that
  /// provider, which would otherwise leave the relay email as the user's name.
  UserModel toUserModel({String? displayNameOverride}) => UserModel.fromAuth(
    uid: uid,
    email: email ?? '',
    displayName: displayNameOverride ?? displayName ?? email ?? '',
    avatarType: AvatarTypes.all[Random().nextInt(AvatarTypes.all.length)].id,
    photoUrl: photoURL,
  );
}
