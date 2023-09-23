import 'package:flutter/material.dart';
import 'package:vbaseproject/features/home_module/home/view/home_view.dart';
import 'package:vbaseproject/features/project_module/projects/projects_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

final class TabModel {
  TabModel({
    required this.page,
    required this.icon,
    required this.title,
  });
  final Widget page;
  final Widget icon;
  final String title;
}

final class TabModels {
  TabModels.create() {
    _tabItems = [
      TabModel(
        page: const HomeView(),
        icon: const Icon(Icons.home_outlined),
        title: LocaleKeys.navigationTabs_placesTabTitle,
      ),
      TabModel(
        page: const ProjectsView(),
        icon: const Icon(Icons.campaign_outlined),
        title: LocaleKeys.navigationTabs_projectsTabTitle,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
