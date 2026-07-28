import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'rate_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class RateModel extends BaseFirebaseModel<RateModel> with EquatableMixin {
  const RateModel({
    this.voterUid = '',
    this.placeId = '',
    this.userName = '',
    this.score = 0,
    this.comment,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.merchantReply,
    this.merchantReplyAt,
  });

  final String voterUid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String placeId;

  final String userName;
  final int score;
  final String? comment;
  final String? photoUrl;

  final String? merchantReply;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? merchantReplyAt;

  bool get hasMerchantReply => merchantReply?.trim().isNotEmpty ?? false;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? updatedAt;

  @override
  String get documentId => voterUid;

  @override
  Map<String, dynamic> toJson() => _$RateModelToJson(this);

  @override
  RateModel fromJson(Map<String, dynamic> json) => _$RateModelFromJson(json);

  @override
  RateModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    if (data == null) return this;
    return fromJson(data).copyWith(
      voterUid: json.id,
      placeId: json.reference.parent.parent?.id ?? '',
    );
  }

  RateModel copyWith({
    String? voterUid,
    String? placeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? score,
    String? comment,
    String? userName,
    String? photoUrl,
    String? merchantReply,
    DateTime? merchantReplyAt,
    bool clearMerchantReply = false,
  }) => RateModel(
    voterUid: voterUid ?? this.voterUid,
    placeId: placeId ?? this.placeId,
    userName: userName ?? this.userName,
    createdAt: createdAt ?? this.createdAt,
    score: score ?? this.score,
    comment: comment ?? this.comment,
    photoUrl: photoUrl ?? this.photoUrl,
    updatedAt: updatedAt ?? this.updatedAt,
    merchantReply: clearMerchantReply
        ? null
        : merchantReply ?? this.merchantReply,
    merchantReplyAt: clearMerchantReply
        ? null
        : merchantReplyAt ?? this.merchantReplyAt,
  );

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
    merchantReply,
    merchantReplyAt,
  ];
}
