import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class CreateGroupModel extends Equatable {
  const CreateGroupModel({
    required this.name,
    required this.category,
    this.description = '',
    this.coverImageFile,
  });

  final String name;
  final GroupCategoryModel category;
  final String description;
  final File? coverImageFile;

  @override
  List<Object?> get props => [name, category, description, coverImageFile];
}
