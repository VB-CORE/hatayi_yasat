import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@immutable
@JsonSerializable()
class NotificationModel with EquatableMixin {
  NotificationModel({
    this.id,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  final String? id;

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [id];

  NotificationModel copyWith({
    String? id,
  }) {
    return NotificationModel(
      id: id ?? this.id,
    );
  }
}
