import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

final class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.role = UserRole.user,
    this.photoUrl,
    this.canCreateGroup = false,
    this.canCreateIssue = false,
  });

  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final String? photoUrl;
  final bool canCreateGroup;
  final bool canCreateIssue;

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        role,
        photoUrl,
        canCreateGroup,
        canCreateIssue,
      ];

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    UserRole? role,
    String? photoUrl,
    bool? canCreateGroup,
    bool? canCreateIssue,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      canCreateGroup: canCreateGroup ?? this.canCreateGroup,
      canCreateIssue: canCreateIssue ?? this.canCreateIssue,
    );
  }
}
