import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:vbaseproject/product/model/firebase/town_model.dart';

class RequestCompanyModel extends Equatable {
  const RequestCompanyModel({
    required this.companyName,
    required this.companyDescription,
    required this.nameSurname,
    required this.address,
    required this.phone,
    required this.town,
    required this.imageFile,
  });

  final String companyName;
  final String companyDescription;
  final String nameSurname;
  final String address;
  final String phone;
  final TownModel town;
  final File imageFile;

  @override
  List<Object> get props => [
        companyName,
        companyDescription,
        nameSurname,
        address,
        phone,
        town,
        imageFile,
      ];
}
