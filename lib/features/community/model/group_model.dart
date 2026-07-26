import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
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
    this.categoryValue = 0,
    this.categoryName = '',
    this.isClosed = false,
    this.memberCount = 0,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  const GroupModel.empty() : this();

  factory GroupModel.fromCategory({
    required String creatorUid,
    required String name,
    required GroupCategoryModel category,
    String description = '',
    String? imageUrl,
  }) {
    return GroupModel(
      creatorUid: creatorUid,
      name: name,
      description: description,
      imageUrl: imageUrl,
      categoryValue: category.value,
      categoryName: category.name,
      memberCount: 1,
    );
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final String creatorUid;
  final String name;
  final String description;
  final String? imageUrl;

  final int categoryValue;
  final String categoryName;

  final bool isClosed;
  final int memberCount;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  final bool isDeleted;

  GroupType get type => isClosed ? GroupType.closed : GroupType.open;

  bool isCreatedBy(String? uid) => uid != null && uid == creatorUid;

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
    categoryValue,
    categoryName,
    isClosed,
    memberCount,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  GroupModel copyWith({
    String? id,
    String? creatorUid,
    String? name,
    String? description,
    String? imageUrl,
    int? categoryValue,
    String? categoryName,
    bool? isClosed,
    int? memberCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return GroupModel(
      id: id ?? this.id,
      creatorUid: creatorUid ?? this.creatorUid,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryValue: categoryValue ?? this.categoryValue,
      categoryName: categoryName ?? this.categoryName,
      isClosed: isClosed ?? this.isClosed,
      memberCount: memberCount ?? this.memberCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
