import 'dart:io';

import 'package:equatable/equatable.dart';

class RequestProjectModel extends Equatable {
  const RequestProjectModel({
    required this.projectName,
    required this.projectTopic,
    required this.projectDescription,
    required this.publisher,
    required this.imageFile,
    required this.startDate,
    required this.endDate,
  });

  final String projectName;
  final String projectTopic;
  final String projectDescription;
  final String publisher;
  final DateTime startDate;
  final DateTime endDate;
  final File imageFile;

  @override
  List<Object> get props => [
        projectName,
        projectTopic,
        projectDescription,
        publisher,
        startDate,
        endDate,
        imageFile,
      ];
}
