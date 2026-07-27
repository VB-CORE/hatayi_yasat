import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/auth/user/user_application_status.dart';

part 'user_application_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class UserApplicationModel extends BaseFirebaseModel<UserApplicationModel>
    with Equatable {
  const UserApplicationModel({
    this.id = '',
    this.status = UserApplicationStatus.pending,
    this.deniedMessage,
    this.ownershipDocumentUrl = '',
    this.createdAt,
    this.updatedAt,
  });

  factory UserApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$UserApplicationModelFromJson(json);

  final String id;

  @JsonKey(
    fromJson: UserApplicationStatus.fromValue,
    toJson: _statusToJson,
  )
  final UserApplicationStatus status;
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
  Map<String, dynamic> toJson() => _$UserApplicationModelToJson(this);

  @override
  UserApplicationModel fromJson(Map<String, dynamic> json) =>
      _$UserApplicationModelFromJson(json);

  @override
  UserApplicationModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    final data = json.data();
    if (data == null) return this;
    return _$UserApplicationModelFromJson(data).copyWith(id: json.id);
  }

  UserApplicationModel copyWith({
    String? id,
    UserApplicationStatus? status,
    String? deniedMessage,
    String? ownershipDocumentUrl,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => UserApplicationModel(
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

int _statusToJson(UserApplicationStatus status) => status.value;
