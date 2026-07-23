import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';

part 'group_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupModel extends BaseFirebaseModel<GroupModel>
    with EquatableMixin {
  const GroupModel({
    this.id = '',
    this.creatorUid = '',
    this.name = '',
    this.description = '',
    this.imageUrl,
    this.isClosed = false,
    this.memberCount = 0,
    this.createdAt,
    this.admins = const [],
  });

  const GroupModel.empty() : this();

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final String creatorUid;
  final String name;
  final String description;
  final String? imageUrl;
  final bool isClosed;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int memberCount;
  @JsonKey(
    includeToJson: false,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<GroupMemberModel> admins;

  GroupType get type => isClosed ? GroupType.closed : GroupType.open;

  bool isAdmin(String memberId) =>
      memberId == creatorUid || admins.any((admin) => admin.id == memberId);

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  @override
  GroupModel fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

  @override
  GroupModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const GroupModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [
    id,
    creatorUid,
    name,
    description,
    imageUrl,
    isClosed,
    memberCount,
    createdAt,
    admins,
  ];

  GroupModel copyWith({
    String? id,
    String? creatorUid,
    String? name,
    String? description,
    String? imageUrl,
    bool? isClosed,
    int? memberCount,
    DateTime? createdAt,
    List<GroupMemberModel>? admins,
  }) {
    return GroupModel(
      id: id ?? this.id,
      creatorUid: creatorUid ?? this.creatorUid,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isClosed: isClosed ?? this.isClosed,
      memberCount: memberCount ?? this.memberCount,
      createdAt: createdAt ?? this.createdAt,
      admins: admins ?? this.admins,
    );
  }
}
