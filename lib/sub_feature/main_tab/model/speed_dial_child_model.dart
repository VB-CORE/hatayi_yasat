import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

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
  SpeedDialChildModelList({required BuildContext context}) {
    _context = context;
    _fillItems(_context);
  }

  late BuildContext _context;

  void _fillItems(BuildContext context) {
    _speedDialChildItems = [
      SpeedDialChildModel(
        location: const PlaceRequestFormRoute().location,
        title: LocaleKeys.requestCompany_title.tr(context: context),
      ),
      SpeedDialChildModel(
        location: const ProjectRequestFormRoute().location,
        title: LocaleKeys.projectRequest_title.tr(context: context),
      ),
      SpeedDialChildModel(
        location: const ScholarShipRequestFormRoute().location,
        title: LocaleKeys.requestScholarship_title.tr(context: context),
      ),
    ];
  }

  late final List<SpeedDialChildModel> _speedDialChildItems;

  List<SpeedDialChildModel> get speedDialChildItems => _speedDialChildItems;
}
