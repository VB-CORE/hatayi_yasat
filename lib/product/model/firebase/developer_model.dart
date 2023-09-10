import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vbaseproject/product/model/base/base_firebase_model.dart';
part 'developer_model.g.dart';

@JsonSerializable()
class DeveloperModel extends BaseFirebaseConvert<DeveloperModel>
    with EquatableMixin {
  DeveloperModel({
    this.id = '',
    this.name,
    this.githubUrl,
    this.image,
  });

  factory DeveloperModel.fromJson(Map<String, dynamic> json) =>
      _$DeveloperModelFromJson(json);

  final String? name;
  @JsonKey(name: 'github_url')
  final String? githubUrl;
  final String? image;
  @override
  final String id;

  Map<String, dynamic> toJson() => _$DeveloperModelToJson(this);

  @override
  List<Object?> get props => [name, githubUrl, image, id];

  @override
  DeveloperModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    if (json.data() == null) return this;
    return DeveloperModel.fromJson(
      json.data()!.map((key, value) => MapEntry(key.trim(), value)),
    ).copyWith(
      id: json.id,
    );
  }

  DeveloperModel copyWith({
    String? id,
    String? name,
    String? githubUrl,
    String? image,
  }) {
    return DeveloperModel(
      id: id ?? this.id,
      name: name ?? this.name,
      githubUrl: githubUrl ?? this.githubUrl,
      image: image ?? this.image,
    );
  }
}
