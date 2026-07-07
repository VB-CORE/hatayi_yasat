import 'package:equatable/equatable.dart';

final class RateModel extends Equatable {
  const RateModel({
    required this.userId,
    required this.esnafId,
    required this.counted,
    required this.createdAt,
    required this.rate,
    this.comment,
  });
  final String userId;
  final String esnafId;
  final bool counted;
  final DateTime createdAt;
  final double rate;
  final String? comment;

  @override
  List<Object?> get props => [
    userId,
    esnafId,
    counted,
    createdAt,
    rate,
    comment,
  ];

  RateModel copyWith({
    String? userId,
    String? esnafId,
    bool? counted,
    DateTime? createdAt,
    double? rate,
    String? comment,
  }) => RateModel(
    userId: userId ?? this.userId,
    esnafId: esnafId ?? this.esnafId,
    counted: counted ?? this.counted,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    comment: comment ?? this.comment,
  );
}
