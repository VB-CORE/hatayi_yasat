import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Single community post in the V2 feed.
///
/// Stored in Firestore at `posts/{id}` (created on first write — see
/// `docs/backend_plan.md` for the schema). Photos are uploaded to
/// Storage at `pending/posts/{authorUid}/{id}/{i}.jpg`.
final class PostModel extends Equatable {
  const PostModel({
    required this.id,
    required this.authorUid,
    required this.authorName,
    required this.authorAvatarColor,
    required this.cityId,
    required this.text,
    required this.photos,
    required this.placeId,
    required this.placeName,
    required this.placeDistrict,
    required this.isMemory,
    required this.year,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.status,
  });

  factory PostModel.fromJson(String id, Map<String, dynamic> json) {
    return PostModel(
      id: id,
      authorUid: json['authorUid'] as String? ?? 'guest',
      authorName: json['authorName'] as String? ?? '',
      authorAvatarColor: json['authorAvatarColor'] as String? ?? 'navy',
      cityId: json['cityId'] as String? ?? 'hatay',
      text: json['text'] as String? ?? '',
      photos: (json['photos'] as List?)?.cast<String>() ?? const <String>[],
      placeId: json['placeId'] as String?,
      placeName: json['placeName'] as String?,
      placeDistrict: json['placeDistrict'] as String?,
      isMemory: json['isMemory'] as bool? ?? false,
      year: (json['year'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: PostStatus.fromString(json['status'] as String?),
    );
  }

  final String id;
  final String authorUid;
  final String authorName;
  final String authorAvatarColor;
  final String cityId;
  final String text;
  final List<String> photos;
  final String? placeId;
  final String? placeName;
  final String? placeDistrict;
  final bool isMemory;
  final int? year;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final PostStatus status;

  Map<String, dynamic> toJson() => {
    'authorUid': authorUid,
    'authorName': authorName,
    'authorAvatarColor': authorAvatarColor,
    'cityId': cityId,
    'text': text,
    'photos': photos,
    'placeId': placeId,
    'placeName': placeName,
    'placeDistrict': placeDistrict,
    'isMemory': isMemory,
    'year': year,
    'likeCount': likeCount,
    'commentCount': commentCount,
    'createdAt': Timestamp.fromDate(createdAt),
    'status': status.name,
  };

  PostModel copyWith({
    int? likeCount,
    int? commentCount,
    PostStatus? status,
  }) => PostModel(
    id: id,
    authorUid: authorUid,
    authorName: authorName,
    authorAvatarColor: authorAvatarColor,
    cityId: cityId,
    text: text,
    photos: photos,
    placeId: placeId,
    placeName: placeName,
    placeDistrict: placeDistrict,
    isMemory: isMemory,
    year: year,
    likeCount: likeCount ?? this.likeCount,
    commentCount: commentCount ?? this.commentCount,
    createdAt: createdAt,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    id,
    authorUid,
    text,
    photos,
    placeId,
    isMemory,
    year,
    likeCount,
    commentCount,
    createdAt,
    status,
  ];
}

enum PostStatus {
  pending,
  approved,
  rejected
  ;

  static PostStatus fromString(String? value) => switch (value) {
    'pending' => PostStatus.pending,
    'rejected' => PostStatus.rejected,
    _ => PostStatus.approved,
  };
}
