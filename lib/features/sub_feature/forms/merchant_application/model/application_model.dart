import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_status.dart';

part 'application_model.g.dart';

@JsonSerializable()
final class Application
    extends BaseFirebaseModel<Application>
    with Equatable {
  const Application({
    this.id = '',
    this.status = MerchantApplicationStatus.pending,
    this.deniedMessage,
    this.ownershipDocumentUrl = '',
    this.createdAt,
    this.updatedAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);

  final String id;

  @JsonKey(
    fromJson: MerchantApplicationStatus.fromValue,
    toJson: _statusToJson,
  )
  final MerchantApplicationStatus status;
  final String? deniedMessage;
  final String ownershipDocumentUrl;

  @override
  String get documentId => id;

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
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);

  @override
  Application fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);

  @override
  Application fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    final data = json.data();
    if (data == null) return this;
    return _$ApplicationFromJson(data).copyWith(id: json.id);
  }

  Application copyWith({
    String? id,
    MerchantApplicationStatus? status,
    String? deniedMessage,
    String? ownershipDocumentUrl,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => Application(
    id: id ?? this.id,
    status: status ?? this.status,
    deniedMessage: deniedMessage ?? this.deniedMessage,
    ownershipDocumentUrl: ownershipDocumentUrl ?? this.ownershipDocumentUrl,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  List<Object?> get props => [
    id,
    status,
    deniedMessage,
    ownershipDocumentUrl,
    createdAt,
    updatedAt,
  ];
}

int _statusToJson(MerchantApplicationStatus status) => status.value;
