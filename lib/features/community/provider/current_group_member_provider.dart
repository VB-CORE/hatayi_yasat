import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_group_member_provider.g.dart';

/// Topluluk ekranlarının ortak "oturumdaki üye" kaynağı. Yetkilendirme
/// bilgisi modellerde taşınmaz; grup/gönderi durumları bu üye üzerinden
/// türetilir.
// TODO(community): Firestore servis PR'ında mock fallback kaldırılacak.
@riverpod
GroupMemberModel currentGroupMember(Ref ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState is Authenticated
      ? GroupMemberModel.fromAppUser(authState.user)
      : CommunityMockData.currentMember;
}
