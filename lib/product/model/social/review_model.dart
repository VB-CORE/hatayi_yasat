import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Review of a place. Stored at `reviews/{id}`. Anonymous reviews keep
/// [authorUid] but flip [anonymous] so the UI hides identity.
final class ReviewModel extends Equatable {
  const ReviewModel({
    required this.id,
    required this.placeId,
    required this.authorUid,
    required this.authorName,
    required this.anonymous,
    required this.rating,
    required this.text,
    required this.createdAt,
    required this.status,
  });

  factory ReviewModel.fromJson(String id, Map<String, dynamic> json) {
    return ReviewModel(
      id: id,
      placeId: json['placeId'] as String? ?? '',
      authorUid: json['authorUid'] as String? ?? 'guest',
      authorName: json['authorName'] as String? ?? '',
      anonymous: json['anonymous'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toInt() ?? 5,
      text: json['text'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: ReviewStatus.fromString(json['status'] as String?),
    );
  }

  final String id;
  final String placeId;
  final String authorUid;
  final String authorName;
  final bool anonymous;
  final int rating;
  final String text;
  final DateTime createdAt;
  final ReviewStatus status;

  Map<String, dynamic> toJson() => {
    'placeId': placeId,
    'authorUid': authorUid,
    'authorName': authorName,
    'anonymous': anonymous,
    'rating': rating,
    'text': text,
    'createdAt': Timestamp.fromDate(createdAt),
    'status': status.name,
  };

  @override
  List<Object?> get props => [id, placeId, authorUid, rating, text, status];
}

enum ReviewStatus {
  pending,
  approved,
  rejected
  ;

  static ReviewStatus fromString(String? value) => switch (value) {
    'pending' => ReviewStatus.pending,
    'rejected' => ReviewStatus.rejected,
    _ => ReviewStatus.approved,
  };
}
