import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class RateModel extends Equatable {
  const RateModel({
    required this.voterUid,
    required this.placeId,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
    required this.score,
    this.comment,
    this.photoUrl,
  });

  factory RateModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RateModel(
      voterUid: doc.id,
      placeId: doc.reference.parent.parent?.id ?? '',
      userName: data['userName'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
      comment: data['comment'] as String?,
      score: (data['score'] as num?)?.toInt() ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  final String voterUid;
  final String placeId;
  final String userName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int score;
  final String? comment;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    voterUid,
    placeId,
    userName,
    createdAt,
    score,
    comment,
    photoUrl,
    updatedAt,
  ];

  Map<String, dynamic> toJson() => {
    'voterUid': voterUid,
    'score': score,
    'userName': userName,
    'photoUrl': photoUrl,
    'comment': comment,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  RateModel copyWith({
    String? voterUid,
    String? placeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? score,
    String? comment,
    String? userName,
    String? photoUrl,
  }) => RateModel(
    voterUid: voterUid ?? this.voterUid,
    placeId: placeId ?? this.placeId,
    userName: userName ?? this.userName,
    createdAt: createdAt ?? this.createdAt,
    score: score ?? this.score,
    comment: comment ?? this.comment,
    photoUrl: photoUrl ?? this.photoUrl,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
