import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';

mixin CommunityQueryMixin on ProjectDependencyMixin {
  Query<GroupModel?> groupsQuery({int? categoryValue}) {
    final visible = firestoreService
        .collectionReference(CommunityPaths.groups, const GroupModel.empty())
        .where(FirestoreFields.isDeleted.name, isEqualTo: false);
    final filtered = categoryValue == null
        ? visible
        : visible.where(_categoryValueField, isEqualTo: categoryValue);
    return filtered.orderBy(FirestoreFields.createdAt.name, descending: true);
  }

  Query<GroupMemberModel?> membersQuery(String groupId) => firestoreService
      .collectionReference(
        CommunityPaths.members(groupId),
        const GroupMemberModel.empty(),
      )
      .where(FirestoreFields.isDeleted.name, isEqualTo: false)
      .orderBy(FirestoreFields.createdAt.name);

  Query<GroupMemberModel?> adminsQuery(String groupId) =>
      membersQuery(groupId).where(_roleField, isEqualTo: _adminRole);

  Query<GroupPostModel?> postsQuery(String groupId) => firestoreService
      .collectionReference(
        CommunityPaths.posts(groupId),
        const GroupPostModel.empty(),
      )
      .where(FirestoreFields.isDeleted.name, isEqualTo: false)
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  Query<GroupDiscussionModel?> discussionsQuery(String groupId) =>
      firestoreService
          .collectionReference(
            CommunityPaths.discussions(groupId),
            const GroupDiscussionModel.empty(),
          )
          .where(FirestoreFields.isDeleted.name, isEqualTo: false)
          .orderBy(FirestoreFields.createdAt.name, descending: true);

  Query<GroupDiscussionEntryModel?> entriesQuery(
    String groupId,
    String discussionId,
  ) => firestoreService
      .collectionReference(
        CommunityPaths.entries(groupId, discussionId),
        const GroupDiscussionEntryModel.empty(),
      )
      .where(FirestoreFields.isDeleted.name, isEqualTo: false)
      .orderBy(FirestoreFields.createdAt.name);

  /// Every post this user liked, across groups. The like documents live under
  /// their post, so this is a collection group scan rather than a per-user list.
  Query<PostLikeModel?> likedPostsQuery(String uid) => FirebaseFirestore.instance
      .collectionGroup(SubCollectionPaths.likes.name)
      .where(_uidField, isEqualTo: uid)
      .where(FirestoreFields.isDeleted.name, isEqualTo: false)
      .withConverter<PostLikeModel?>(
        fromFirestore: (snapshot, _) =>
            const PostLikeModel.empty().fromFirebase(snapshot),
        toFirestore: (_, _) => throw UnimplementedError(),
      );

  static const String _categoryValueField = 'categoryValue';
  static const String _uidField = 'uid';
  static const String _roleField = 'role';
  static final int _adminRole = GroupMemberRole.admin.value;
}
