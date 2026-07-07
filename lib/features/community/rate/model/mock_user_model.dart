import 'package:equatable/equatable.dart';

final class MockUserModel extends Equatable {
  const MockUserModel({
    required this.id,
    required this.name,
    this.photoUrl,
  });
  final String id;
  final String name;
  final String? photoUrl;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.map((p) => p[0].toUpperCase()).take(2).join();
  }

  @override
  List<Object?> get props => [id, name, photoUrl];
}
