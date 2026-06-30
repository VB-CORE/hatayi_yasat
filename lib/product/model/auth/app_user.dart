import 'package:lifeclient/product/model/auth/user_role.dart';

final class AppUser {
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
}
