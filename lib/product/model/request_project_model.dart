import 'dart:io';

import 'package:equatable/equatable.dart';

final class RequestProjectModel extends Equatable {
  const RequestProjectModel({
    required this.projectName,
    required this.projectTopic,
    required this.projectDescription,
    required this.publisher,
    required this.phone,
    required this.imageFile,
    required this.expireDate,
  });

  final String projectName;
  final String projectTopic;
  final String projectDescription;
  final String publisher;
  final String phone;
  final DateTime expireDate;
  // TODO: replace file to String for iamge url instead of file
  final File imageFile;

  @override
  List<Object> get props => [
        projectName,
        projectTopic,
        projectDescription,
        publisher,
        expireDate,
        imageFile,
        phone,
      ];

  static RequestProjectModel dummyData = RequestProjectModel(
    projectName: 'Yazılım Kursu',
    projectTopic: 'Mobil Uygulama Geliştirme',
    projectDescription:
        'Bu kurs, mobil uygulama geliştirmeye yönelik temel bilgileri kapsar.',
    publisher: 'ABC Eğitim Kurumu',
    phone: '+90 123 456 78 90',
    expireDate: DateTime.now().add(const Duration(days: 45)),
    imageFile: File(''),
  );
}
