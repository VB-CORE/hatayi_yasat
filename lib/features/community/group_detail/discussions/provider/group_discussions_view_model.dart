import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_discussions_view_model.g.dart';

@riverpod
final class GroupDiscussionsViewModel extends _$GroupDiscussionsViewModel
    with ProjectDependencyMixin {
  @override
  GroupDiscussionsState build() =>
      const GroupDiscussionsState(discussions: [], isFetching: true);

  FirestoreCollectionPath _discussionsPath(String groupId) =>
      CollectionPaths.groups.sub(groupId, SubCollectionPaths.discussions);

  FirestoreCollectionPath _entriesPath(String groupId, String discussionId) =>
      CollectionPaths.groups
          .sub(groupId, SubCollectionPaths.discussions)
          .sub(discussionId, SubCollectionPaths.entries);

  Future<void> fetchDiscussions(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupDiscussionModel>(
      model: const GroupDiscussionModel.empty(),
      path: _discussionsPath(groupId),
    );
    if (!result.isSuccess) {
      state = state.copyWith(isFetching: false, isError: true);
      return;
    }
    final discussions = (result.dataOrNull ?? const <GroupDiscussionModel>[])
        .where((discussion) => !discussion.isDeleted)
        .toList();
    final withCounts = await Future.wait(
      discussions.map((discussion) async {
        final count = await _entryCount(groupId, discussion.id);
        return discussion.copyWith(entryCount: count);
      }),
    );
    withCounts.sort(
      (a, b) =>
          (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
    );
    state = state.copyWith(discussions: withCounts, isFetching: false);
  }

  Future<GroupDiscussionModel?> addDiscussion(
    String groupId,
    String title,
    String message,
  ) async {
    final currentMember = ref.read(currentGroupMemberProvider);
    final discussion = GroupDiscussionModel(
      title: title,
      author: currentMember,
    );
    final discussionResult = await firestoreService.add<GroupDiscussionModel>(
      model: discussion,
      path: _discussionsPath(groupId),
    );
    final discussionId = discussionResult.dataOrNull;
    if (discussionId == null) return null;

    final entry = GroupDiscussionEntryModel(
      author: currentMember,
      content: message,
    );
    final entryResult = await firestoreService.add<GroupDiscussionEntryModel>(
      model: entry,
      path: _entriesPath(groupId, discussionId),
    );
    if (entryResult.dataOrNull == null) {
      await firestoreService.updateFields(
        path: _discussionsPath(groupId),
        documentId: discussionId,
        fields: {
          'isDeleted': true,
          'deletedAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
      return null;
    }

    final created = discussion.copyWith(
      id: discussionId,
      createdAt: DateTime.now(),
      entryCount: 1,
    );
    state = state.copyWith(discussions: [created, ...state.discussions]);
    return created;
  }

  Future<int> _entryCount(String groupId, String discussionId) async {
    final result = await firestoreService.getList<GroupDiscussionEntryModel>(
      model: const GroupDiscussionEntryModel.empty(),
      path: _entriesPath(groupId, discussionId),
    );
    return (result.dataOrNull ?? const <GroupDiscussionEntryModel>[])
        .where((entry) => !entry.isDeleted)
        .length;
  }
}
