import 'package:life_shared/life_shared.dart';

final class CommunityContentPermission {
  const CommunityContentPermission._();

  static bool canDelete({
    required String authorUid,
    required GroupMemberModel? currentMember,
  }) {
    if (currentMember == null) return false;
    return authorUid == currentMember.uid || currentMember.isAdmin;
  }
}
