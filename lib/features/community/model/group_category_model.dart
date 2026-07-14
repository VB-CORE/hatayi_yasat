import 'package:equatable/equatable.dart';

final class GroupCategoryModel extends Equatable {
  const GroupCategoryModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
