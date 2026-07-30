// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
  voterUid: json['voterUid'] as String? ?? '',
  userName: json['userName'] as String? ?? '',
  score: (json['score'] as num?)?.toInt() ?? 0,
  comment: json['comment'] as String?,
  avatarType: (json['avatarType'] as num?)?.toInt() ?? 1,
  createdAt: json['createdAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: json['updatedAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
  merchantReply: json['merchantReply'] as String?,
  merchantReplyAt: FirebaseTimeParse.datetimeFromTimestamp(
    json['merchantReplyAt'],
  ),
);

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
  'voterUid': instance.voterUid,
  'userName': instance.userName,
  'score': instance.score,
  'comment': ?instance.comment,
  'avatarType': instance.avatarType,
  'merchantReply': instance.merchantReply,
  'merchantReplyAt': ?FirebaseTimeParse.dateTimeToTimestamp(
    instance.merchantReplyAt,
  ),
  'createdAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
  'updatedAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
};
