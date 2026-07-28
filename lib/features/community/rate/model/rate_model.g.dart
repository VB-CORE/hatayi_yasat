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
  avatarType:
      $enumDecodeNullable(_$AvatarTypeEnumMap, json['avatarType']) ??
      AvatarType.a1,
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
  'avatarType': _$AvatarTypeEnumMap[instance.avatarType]!,
  'createdAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
  'updatedAt': ?FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
};

const _$AvatarTypeEnumMap = {
  AvatarType.a1: 'a1',
  AvatarType.a2: 'a2',
  AvatarType.a3: 'a3',
  AvatarType.a4: 'a4',
  AvatarType.a5: 'a5',
  AvatarType.a6: 'a6',
  AvatarType.a7: 'a7',
};
