import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class CommunityPaths {
  const CommunityPaths._();

  static const FirestoreCollectionPath groups = CollectionPaths.groups;
  static const FirestoreCollectionPath categories =
      CollectionPaths.groupCategories;

  static FirestoreCollectionPath members(String groupId) =>
      groups.sub(groupId, SubCollectionPaths.members);

  static FirestoreCollectionPath posts(String groupId) =>
      groups.sub(groupId, SubCollectionPaths.posts);

  static FirestoreCollectionPath discussions(String groupId) =>
      groups.sub(groupId, SubCollectionPaths.discussions);

  static FirestoreCollectionPath entries(String groupId, String discussionId) =>
      discussions(groupId).sub(discussionId, SubCollectionPaths.entries);

  static FirestoreCollectionPath likedPosts(String uid) =>
      CollectionPaths.users.sub(uid, SubCollectionPaths.likedPosts);
}
