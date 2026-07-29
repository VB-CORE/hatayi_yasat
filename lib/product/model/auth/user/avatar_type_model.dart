import 'package:equatable/equatable.dart';

final class AvatarTypeModel extends Equatable {
  const AvatarTypeModel({required this.name, required this.path});

  final String name;
  final String path;

  @override
  List<Object?> get props => [name, path];
}
