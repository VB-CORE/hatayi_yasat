import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Memory contributed by a user. Same shape as a post + era / neighborhood
/// metadata and a separate love counter. Stored at `memories/{id}`.
final class MemoryModel extends Equatable {
  const MemoryModel({
    required this.id,
    required this.authorUid,
    required this.authorName,
    required this.cityId,
    required this.title,
    required this.text,
    required this.year,
    required this.era,
    required this.neighborhood,
    required this.photos,
    required this.loveCount,
    required this.createdAt,
    required this.status,
  });

  factory MemoryModel.fromJson(String id, Map<String, dynamic> json) {
    return MemoryModel(
      id: id,
      authorUid: json['authorUid'] as String? ?? 'guest',
      authorName: json['authorName'] as String? ?? '',
      cityId: json['cityId'] as String? ?? 'hatay',
      title: json['title'] as String? ?? '',
      text: json['text'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      era: json['era'] as String? ?? '',
      neighborhood: json['neighborhood'] as String? ?? '',
      photos: (json['photos'] as List?)?.cast<String>() ?? const <String>[],
      loveCount: (json['loveCount'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: MemoryStatus.fromString(json['status'] as String?),
    );
  }

  final String id;
  final String authorUid;
  final String authorName;
  final String cityId;
  final String title;
  final String text;
  final int year;
  final String era;
  final String neighborhood;
  final List<String> photos;
  final int loveCount;
  final DateTime createdAt;
  final MemoryStatus status;

  Map<String, dynamic> toJson() => {
    'authorUid': authorUid,
    'authorName': authorName,
    'cityId': cityId,
    'title': title,
    'text': text,
    'year': year,
    'era': era,
    'neighborhood': neighborhood,
    'photos': photos,
    'loveCount': loveCount,
    'createdAt': Timestamp.fromDate(createdAt),
    'status': status.name,
  };

  MemoryModel copyWith({int? loveCount, MemoryStatus? status}) => MemoryModel(
    id: id,
    authorUid: authorUid,
    authorName: authorName,
    cityId: cityId,
    title: title,
    text: text,
    year: year,
    era: era,
    neighborhood: neighborhood,
    photos: photos,
    loveCount: loveCount ?? this.loveCount,
    createdAt: createdAt,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [id, title, year, era, neighborhood, loveCount];
}

enum MemoryStatus {
  pending,
  approved,
  rejected
  ;

  static MemoryStatus fromString(String? value) => switch (value) {
    'pending' => MemoryStatus.pending,
    'rejected' => MemoryStatus.rejected,
    _ => MemoryStatus.approved,
  };
}
