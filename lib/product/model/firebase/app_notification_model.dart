import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vbaseproject/product/model/base/base_firebase_model.dart';

part 'app_notification_model.g.dart';

@JsonSerializable()
class AppNotificationModel extends BaseFirebaseConvert<AppNotificationModel>
    with EquatableMixin {
  AppNotificationModel({
    this.body,
    this.id = '',
    this.title,
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);
  final String? body;
  @override
  final String id;
  final String? title;

  Map<String, dynamic> toJson() => _$AppNotificationModelToJson(this);

  @override
  List<Object?> get props => [body, id, title];

  AppNotificationModel copyWith({
    String? body,
    String? id,
    String? title,
  }) {
    return AppNotificationModel(
      body: body ?? this.body,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  AppNotificationModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    return AppNotificationModel.fromJson(json.data()!);
  }
}
