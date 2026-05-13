import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// V2 user profile sourced from `user_profiles/{uid}`.
///
/// FirebaseAuth is not yet wired (see `docs/backend_plan.md`); when no
/// document is present, repositories return [UserProfile.guest] so the
/// rest of the UI can stay agnostic.
final class UserProfile extends Equatable {
  const UserProfile({
    required this.uid,
    required this.handle,
    required this.displayName,
    required this.avatarColorHex,
    required this.district,
    required this.cityId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(String uid, Map<String, dynamic> json) {
    return UserProfile(
      uid: uid,
      handle: json['handle'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatarColorHex: json['avatarColorHex'] as String? ?? '#0F2A47',
      district: json['district'] as String? ?? '',
      cityId: json['cityId'] as String? ?? 'hatay',
      role: UserRole.fromString(json['role'] as String?),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Default profile returned when there is no signed-in user.
  static UserProfile guest() {
    final now = DateTime.now();
    return UserProfile(
      uid: 'guest',
      handle: 'guest',
      displayName: '',
      avatarColorHex: '#0F2A47',
      district: '',
      cityId: 'hatay',
      role: UserRole.guest,
      createdAt: now,
      updatedAt: now,
    );
  }

  final String uid;
  final String handle;
  final String displayName;
  final String avatarColorHex;
  final String district;
  final String cityId;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isGuest => role == UserRole.guest || uid == 'guest';
  bool get isMerchant => role == UserRole.merchant;
  bool get isAdmin => role == UserRole.admin;

  Map<String, dynamic> toJson() => {
    'handle': handle,
    'displayName': displayName,
    'avatarColorHex': avatarColorHex,
    'district': district,
    'cityId': cityId,
    'role': role.name,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  UserProfile copyWith({
    String? handle,
    String? displayName,
    String? avatarColorHex,
    String? district,
    String? cityId,
    UserRole? role,
    DateTime? updatedAt,
  }) => UserProfile(
    uid: uid,
    handle: handle ?? this.handle,
    displayName: displayName ?? this.displayName,
    avatarColorHex: avatarColorHex ?? this.avatarColorHex,
    district: district ?? this.district,
    cityId: cityId ?? this.cityId,
    role: role ?? this.role,
    createdAt: createdAt,
    updatedAt: updatedAt ?? DateTime.now(),
  );

  @override
  List<Object?> get props => [uid, handle, displayName, role, cityId];
}

enum UserRole {
  guest,
  user,
  merchant,
  admin
  ;

  static UserRole fromString(String? value) => switch (value) {
    'merchant' => UserRole.merchant,
    'admin' => UserRole.admin,
    'guest' => UserRole.guest,
    _ => UserRole.user,
  };
}
