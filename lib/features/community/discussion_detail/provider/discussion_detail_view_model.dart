import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_detail_view_model.g.dart';

@riverpod
final class DiscussionDetailViewModel extends _$DiscussionDetailViewModel
    with ProjectDependencyMixin {
  @override
  DiscussionDetailState build() => DiscussionDetailState(
    entries: const [],
    currentMember: ref.read(currentGroupMemberProvider),
    isFetching: true,
  );

  FirestoreCollectionPath _entriesPath(String groupId, String discussionId) =>
      CollectionPaths.groups
          .sub(groupId, SubCollectionPaths.discussions)
          .sub(discussionId, SubCollectionPaths.entries);

  Future<void> fetchEntries(String groupId, String discussionId) async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupDiscussionEntryModel>(
      model: const GroupDiscussionEntryModel.empty(),
      path: _entriesPath(groupId, discussionId),
    );
    final entries =
        (result.dataOrNull ?? const <GroupDiscussionEntryModel>[])
            .where((entry) => !entry.isDeleted)
            .toList()
          ..sort(
            (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
              b.createdAt ?? DateTime(0),
            ),
          );
    state = state.copyWith(
      entries: entries,
      isFetching: false,
      isError: !result.isSuccess,
    );
  }

  Future<bool> addEntry(
    String groupId,
    String discussionId,
    String content,
  ) async {
    final entry = GroupDiscussionEntryModel.fromAuthor(
      author: state.currentMember,
      content: content,
    );
    final result = await firestoreService.add<GroupDiscussionEntryModel>(
      model: entry,
      path: _entriesPath(groupId, discussionId),
    );
    final id = result.dataOrNull;
    if (id == null) return false;
    state = state.copyWith(
      entries: [
        ...state.entries,
        entry.copyWith(id: id),
      ],
    );
    return true;
  }
}
