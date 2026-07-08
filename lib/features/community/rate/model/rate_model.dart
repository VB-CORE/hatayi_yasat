import 'package:equatable/equatable.dart';

final class RateModel extends Equatable {
  const RateModel({
    required this.userId,
    required this.esnafId,
    required this.counted,
    required this.userName,
    required this.createdAt,
    required this.rate,
    this.comment,
    this.photoUrl,
  });
  final String userId;
  final String esnafId;
  final String userName;
  final bool counted;
  final DateTime createdAt;
  final double rate;
  final String? comment;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    userId,
    esnafId,
    userName,
    counted,
    createdAt,
    rate,
    comment,
    photoUrl,
  ];

  RateModel copyWith({
    String? userId,
    String? esnafId,
    bool? counted,
    DateTime? createdAt,
    double? rate,
    String? comment,
    String? userName,
    String? photoUrl,
  }) => RateModel(
    userId: userId ?? this.userId,
    esnafId: esnafId ?? this.esnafId,
    userName: userName ?? this.userName,
    counted: counted ?? this.counted,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    comment: comment ?? this.comment,
    photoUrl: photoUrl ?? this.photoUrl,
  );

  String get initials {
    final parts = userName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.map((p) => p[0].toUpperCase()).take(2).join();
  }
}
