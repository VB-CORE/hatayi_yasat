import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:vbaseproject/product/model/base/base_firebase_model.dart';

part 'store_model.g.dart';

@immutable
@JsonSerializable()
final class StoreModel extends BaseFirebaseModel<StoreModel> {
  StoreModel({
    required this.name,
    required this.owner,
    required this.address,
    required this.phone,
    required this.images,
    required this.townCode,
    required this.createdAt,
    required this.updatedAt,
    required this.isApproved,
    required this.deviceID,
    this.description,
  });

  final String name;
  final String owner;
  final String? description;
  final String address;
  final String phone;
  final List<String> images;
  final int townCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isApproved;
  final String deviceID;

  @override
  Map<String, dynamic> toJson() {
    return _$StoreModelToJson(this);
  }
}
