import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class RequestScholarshipModel extends Equatable {
  const RequestScholarshipModel({
    required this.email,
    required this.phoneNumber,
    required this.story,
    required this.studentDocument,
  });

  final String email;
  final String phoneNumber;
  final String story;
  final File? studentDocument;

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        story,
        studentDocument,
      ];

  RequestScholarshipModel copyWith({
    String? email,
    String? phoneNumber,
    String? story,
    File? studentDocument,
  }) {
    return RequestScholarshipModel(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      story: story ?? this.story,
      studentDocument: studentDocument ?? this.studentDocument,
    );
  }
}
