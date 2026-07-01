import 'package:equatable/equatable.dart';

final class RateModel with EquatableMixin {
  RateModel({
    required this.counted,
    required this.createdAt,
    required this.rate,
    this.comment,
  });

  final bool counted;
  final DateTime createdAt;
  final double rate;
  final String? comment;

  @override
  List<Object?> get props => [counted, createdAt, rate, comment];

  RateModel copyWith({
    bool? counted,
    DateTime? createdAt,
    double? rate,
    String? comment,
  }) => RateModel(
    counted: counted ?? this.counted,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    comment: comment ?? this.comment,
  );
}
