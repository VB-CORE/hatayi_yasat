import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_detail_view_model.g.dart';

@riverpod
final class DiscussionDetailViewModel extends _$DiscussionDetailViewModel
    with ProjectDependencyMixin {
  static const _localIdPrefix = 'local-';

  @override
  DiscussionDetailState build() => DiscussionDetailState(
    entries: const [],
    currentMember: ref.read(currentGroupMemberProvider),
    isFetching: true,
  );

  // TODO(community): Firestore servis PR'ında mock yerine gerçek istek gelecek.
  void fetchEntries(GroupDiscussionModel discussion) {
    state = state.copyWith(
      entries: discussion.entries,
      isFetching: false,
      isError: false,
    );
  }

  // TODO(community): Firestore servis PR'ında gönderi sunucuya yazılacak.
  void addEntry(String content) {
    final entry = GroupDiscussionEntryModel(
      id: '$_localIdPrefix${DateTime.now().microsecondsSinceEpoch}',
      author: state.currentMember,
      content: content,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(entries: [...state.entries, entry]);
  }
}
