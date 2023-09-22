import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

abstract class BaseModel {
  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  DateTime? createdAt = DateTime.now();
  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  DateTime? updatedAt = DateTime.now();
}
