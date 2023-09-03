// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:vbaseproject/product/model/base/base_firebase_model.dart';

part 'town_model.g.dart';

@JsonSerializable()
class TownModel extends BaseFirebaseConvert<TownModel> with EquatableMixin {
  TownModel({
    this.code,
    this.name,
    this.id = '',
  });

  factory TownModel.fromJson(Map<String, dynamic> json) =>
      _$TownModelFromJson(json);

  final int? code;
  final String? name;
  @override
  final String id;

  TownModel fromJson(Map<String, dynamic> json) => _$TownModelFromJson(json);

  Map<String, dynamic> toJson() => _$TownModelToJson(this);

  @override
  List<Object?> get props => [code, name, id];

  @override
  TownModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() == null) return this;
    return TownModel.fromJson(
      snapshot.data()!.map((key, value) => MapEntry(key.trim(), value)),
    ).copyWith(
      id: snapshot.id,
    );
  }

  TownModel copyWith({
    int? code,
    String? name,
    String? id,
  }) {
    return TownModel(
      code: code ?? this.code,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
