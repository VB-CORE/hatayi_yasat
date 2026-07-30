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

  Query<LikedPostModel?> likedPostsQuery(String uid) => firestoreService
      .collectionReference(
        CommunityPaths.likedPosts(uid),
        const LikedPostModel.empty(),
      )
      .where(FirestoreFields.isDeleted.name, isEqualTo: false)
      .orderBy(_likedAtField, descending: true);

  static const String _categoryValueField = 'categoryValue';
  static const String _likedAtField = 'likedAt';
  static const String _roleField = 'role';
  static final String _adminRole = GroupMemberRole.admin.name;
}
