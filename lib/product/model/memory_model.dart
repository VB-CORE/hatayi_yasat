import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'memory_model.g.dart';

@JsonSerializable()
@immutable
final class MemoryModel with EquatableMixin {
  MemoryModel({
    required this.documentId,
    this.title,
    this.description,
    this.imageUrl,
    this.thumbnailUrl,
    this.userId,
    this.isPublic = true,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory MemoryModel.fromJson(Map<String, dynamic> json) =>
      _$MemoryModelFromJson(json);

  factory MemoryModel.empty() => MemoryModel(documentId: '');

  final String documentId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? userId;
  final bool isPublic;
  final List<String> tags;

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
        thumbnailUrl,
        userId,
        isPublic,
        tags,
        createdAt,
        updatedAt,
      ];

  MemoryModel copyWith({
    String? documentId,
    String? title,
    String? description,
    String? imageUrl,
    String? thumbnailUrl,
    String? userId,
    bool? isPublic,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemoryModel(
      documentId: documentId ?? this.documentId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      userId: userId ?? this.userId,
      isPublic: isPublic ?? this.isPublic,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
