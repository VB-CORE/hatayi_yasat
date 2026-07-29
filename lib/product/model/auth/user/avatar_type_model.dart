import 'package:equatable/equatable.dart';

final class AvatarTypeModel extends Equatable {
  const AvatarTypeModel({required this.id, required this.path});

  final int id;
  final String path;

  @override
  List<Object?> get props => [id, path];
}
