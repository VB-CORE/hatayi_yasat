import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';

@immutable
final class SpeedDialChildModel {
  const SpeedDialChildModel({
    required this.location,
    required this.title,
  });

  /// route path adress
  final String location;
  final String title;
}

final class SpeedDialChildModelList {
  SpeedDialChildModelList() {
    _fillItems();
  }

  void _fillItems() {
    _speedDialChildItems = [
      SpeedDialChildModel(
        location: const PlaceRequestFormRoute().location,
        title: LocaleKeys.requestCompany_title,
      ),
      SpeedDialChildModel(
        location: const ProjectRequestFormRoute().location,
        title: LocaleKeys.projectRequest_title,
      ),
      SpeedDialChildModel(
        location: const ScholarShipRequestFormRoute().location,
        title: LocaleKeys.requestScholarship_title,
      ),
    ];
  }

  late final List<SpeedDialChildModel> _speedDialChildItems;

  List<SpeedDialChildModel> get speedDialChildItems => _speedDialChildItems;
}
