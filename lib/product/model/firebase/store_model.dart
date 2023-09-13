import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:vbaseproject/product/model/base/base_firebase_model.dart';

import 'package:vbaseproject/product/utility/firebase/time_parser.dart';

part 'store_model.g.dart';

@immutable
@JsonSerializable()
final class StoreModel extends BaseFirebaseModel<StoreModel>
    implements BaseFirebaseConvert<StoreModel> {
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
    this.id = '',
    this.description,
  });

  factory StoreModel.empty() {
    return StoreModel(
      name: '',
      owner: '',
      address: '',
      phone: '',
      images: const [],
      townCode: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isApproved: false,
      deviceID: '',
      description: '',
    );
  }

  final String name;
  final String owner;
  final String? description;
  final String? address;
  final String phone;
  final List<String> images;
  final int townCode;

  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParser.dateTimeToTimestamp,
    fromJson: FirebaseTimeParser.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? updatedAt;
  final bool isApproved;
  final String? deviceID;

  // make a copywith
  StoreModel copyWith({
    String? name,
    String? owner,
    String? description,
    String? address,
    String? phone,
    List<String>? images,
    int? townCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isApproved,
    String? deviceID,
    String? id,
  }) {
    return StoreModel(
      name: name ?? this.name,
      owner: owner ?? this.owner,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      images: images ?? this.images,
      townCode: townCode ?? this.townCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isApproved: isApproved ?? this.isApproved,
      deviceID: deviceID ?? this.deviceID,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$StoreModelToJson(this);
  }

  @override
  StoreModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return this;
    return _$StoreModelFromJson(snapshot.data()!).copyWith(
      id: snapshot.id,
    );
  }

  @override
  final String id;
}
