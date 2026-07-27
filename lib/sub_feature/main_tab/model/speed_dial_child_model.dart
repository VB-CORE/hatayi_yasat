import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

@immutable
final class SpeedDialChildModel {
  const SpeedDialChildModel({
    required this.location,
    required this.title,
    this.isVisible = true,
  });

  final String location;
  final String title;

  final bool isVisible;
}

final class SpeedDialChildModelList {
  SpeedDialChildModelList({
    required BuildContext context,
    this.canCreateGroup = false, 
  }) {
    _context = context;
    _fillItems(_context);
  }

  final bool canCreateGroup; 
  late BuildContext _context;

  void _fillItems(BuildContext context) {
    _speedDialChildItems = [
      SpeedDialChildModel(
        location: const CreateGroupRoute().location,
        title: LocaleKeys.community_createGroup_title.tr(context: context),
        isVisible: canCreateGroup,
      ),
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

  List<SpeedDialChildModel> get speedDialChildItems =>
      _speedDialChildItems.where((item) => item.isVisible).toList();
}
