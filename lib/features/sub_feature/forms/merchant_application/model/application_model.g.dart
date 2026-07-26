// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
  id: json['id'] as String? ?? '',
  status: json['status'] == null
      ? MerchantApplicationStatus.pending
      : MerchantApplicationStatus.fromValue((json['status'] as num?)?.toInt()),
  deniedMessage: json['deniedMessage'] as String?,
  ownershipDocumentUrl: json['ownershipDocumentUrl'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: json['updatedAt'] == null
      ? DateTime.now()
      : FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
);

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _statusToJson(instance.status),
      'deniedMessage': instance.deniedMessage,
      'ownershipDocumentUrl': instance.ownershipDocumentUrl,
      'createdAt': FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
      'updatedAt': FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
    };
