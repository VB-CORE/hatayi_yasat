import 'dart:io';

import 'package:equatable/equatable.dart';

final class RequestProjectModel extends Equatable {
  const RequestProjectModel({
    required this.projectName,
    required this.projectTopic,
    required this.projectDescription,
    required this.publisher,
    required this.imageFile,
    required this.startDate,
  });

  final String projectName;
  final String projectTopic;
  final String projectDescription;
  final String publisher;
  final DateTime startDate;
  final File imageFile;

  @override
  List<Object> get props => [
        projectName,
        projectTopic,
        projectDescription,
        publisher,
        startDate,
        imageFile,
      ];
}
