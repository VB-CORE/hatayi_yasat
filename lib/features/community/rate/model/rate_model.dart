import 'package:equatable/equatable.dart';

final class RateModel extends Equatable {
  const RateModel({
    required this.userId,
    required this.placeId,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
    required this.rate,
    this.comment,
    this.photoUrl,
  });
  final String userId;
  final String placeId;
  final String userName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double rate;
  final String? comment;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    userId,
    placeId,
    userName,
    createdAt,
    rate,
    comment,
    photoUrl,
    updatedAt,
  ];

  RateModel copyWith({
    String? userId,
    String? placeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? rate,
    String? comment,
    String? userName,
    String? photoUrl,
  }) => RateModel(
    userId: userId ?? this.userId,
    placeId: placeId ?? this.placeId,
    userName: userName ?? this.userName,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    comment: comment ?? this.comment,
    photoUrl: photoUrl ?? this.photoUrl,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
