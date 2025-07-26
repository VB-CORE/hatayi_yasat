import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'memory_model.g.dart';

@JsonSerializable()
@immutable
final class MemoryModel
    with EquatableMixin
    implements BaseFirebaseConvert<MemoryModel> {
  const MemoryModel({
    required this.documentId,
    this.title,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory MemoryModel.fromJson(Map<String, dynamic> json) =>
      _$MemoryModelFromJson(json);

  factory MemoryModel.empty() => const MemoryModel(documentId: '');

  @override
  final String documentId;
  final String? title;
  final String? description;
  final List<String>? imageUrl;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$MemoryModelToJson(this);

  @override
  List<Object?> get props => [
        documentId,
        title,
        description,
        imageUrl,
        createdAt,
        updatedAt,
      ];

  MemoryModel copyWith({
    String? documentId,
    String? title,
    String? description,
    List<String>? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemoryModel(
      documentId: documentId ?? this.documentId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  MemoryModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    return MemoryModel.fromJson(json.data() ?? {})
      ..copyWith(documentId: json.id);
  }
}
