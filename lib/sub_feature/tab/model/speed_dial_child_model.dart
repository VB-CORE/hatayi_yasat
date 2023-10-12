import 'package:flutter/material.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/features/request/project/request_project_view.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

@immutable
final class SpeedDialChildModel {
  const SpeedDialChildModel({
    required this.destination,
    required this.title,
  });

  final Widget destination;
  final String title;
}

final class SpeedDialChildModelList {
  SpeedDialChildModelList() {
    _fillItems();
  }

  void _fillItems() {
    _speedDialChildItems = [
      const SpeedDialChildModel(
        destination: RequestProjectView(),
        title: LocaleKeys.projectRequest_title,
      ),
      const SpeedDialChildModel(
        destination: RequestCompanyView(),
        title: LocaleKeys.requestCompany_title,
      ),
      const SpeedDialChildModel(
        destination: RequestScholarshipView(),
        title: LocaleKeys.request_scholarship_title,
      ),
    ];
  }

  late final List<SpeedDialChildModel> _speedDialChildItems;

  List<SpeedDialChildModel> get speedDialChildItems => _speedDialChildItems;
}
