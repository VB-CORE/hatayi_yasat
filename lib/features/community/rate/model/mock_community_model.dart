import 'package:equatable/equatable.dart';

final class MockCommunityModel extends Equatable {
  const MockCommunityModel({
    required this.esnafId,
    required this.isComment,
  });
  final String esnafId;
  final bool isComment;

  @override
  List<Object?> get props => [esnafId, isComment];
}
