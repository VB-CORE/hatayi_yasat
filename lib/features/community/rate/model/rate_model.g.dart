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
  photoUrl: json['photoUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: json['updatedAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
);

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
  'voterUid': instance.voterUid,
  'userName': instance.userName,
  'score': instance.score,
  'comment': ?instance.comment,
  'photoUrl': ?instance.photoUrl,
  'createdAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
  'updatedAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
};
