import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';

@immutable
final class GroupWallState extends Equatable {
  const GroupWallState({
    required this.posts,
    required this.currentMember,
    this.likedPostIds = const {},
    this.isFetching = false,
    this.isError = false,
  });

  final List<GroupPostModel> posts;
  final GroupMemberModel currentMember;

  /// Oturumdaki üyenin beğendiği gönderiler; sunucu modeline ait değildir.
  final Set<String> likedPostIds;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [
    posts,
    currentMember,
    likedPostIds,
    isFetching,
    isError,
  ];

  GroupWallState copyWith({
    List<GroupPostModel>? posts,
    GroupMemberModel? currentMember,
    Set<String>? likedPostIds,
    bool? isFetching,
    bool? isError,
  }) {
    return GroupWallState(
      posts: posts ?? this.posts,
      currentMember: currentMember ?? this.currentMember,
      likedPostIds: likedPostIds ?? this.likedPostIds,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
