import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_detail_view_model.g.dart';

@riverpod
final class DiscussionDetailViewModel extends _$DiscussionDetailViewModel
    with ProjectDependencyMixin {
  @override
  DiscussionDetailState build() => DiscussionDetailState(
    entries: const [],
    currentMember: _currentMember,
    isFetching: true,
  );

  // TODO(community): Firestore group_discussions/{id}/entries koleksiyonu
  // hazır olunca firebaseService üzerinden gerçek sorguya bağlanacak. Şu an
  // tartışmanın mock/local entries listesi doğrudan kaynak.
  Future<void> fetchEntries(GroupDiscussionModel discussion) async {
    state = state.copyWith(isFetching: true, isError: false);
    state = state.copyWith(entries: discussion.entries, isFetching: false);
  }

  // TODO(community): Firestore'a gerçek gönderi yazımı bağlanacak.
  void addEntry(String content) {
    final entry = GroupDiscussionEntryModel(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      author: state.currentMember,
      content: content,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(entries: [...state.entries, entry]);
  }

  // TODO(community): Gerçek grup üyeliği verisi bağlanınca mock fallback
  // kaldırılacak.
  GroupMemberModel get _currentMember {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated
        ? GroupMemberModel.fromAppUser(authState.user)
        : CommunityMockData.currentMember;
  }
}
