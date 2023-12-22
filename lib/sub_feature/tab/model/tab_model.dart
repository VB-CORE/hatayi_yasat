import 'package:flutter/material.dart';
import 'package:vbaseproject/features/v2/event/view/event_view.dart';
import 'package:vbaseproject/features/v2/home/view/home_view.dart';
import 'package:vbaseproject/features/v2/news_jobs/view/news_jobs_view.dart';
import 'package:vbaseproject/features/v2/settings/view/settings_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';

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
        icon: const Icon(AppIcons.home),
        title: LocaleKeys.navigationTabs_placesTabTitle,
      ),
      TabModel(
        page: const EventView(),
        icon: const Icon(AppIcons.event),
        title: LocaleKeys.navigationTabs_campaignsTabTitle,
      ),
      TabModel(
        page: const NewsJobsView(),
        icon: const Icon(AppIcons.textSnippet),
        title: LocaleKeys.navigationTabs_newsTabTitle,
      ),
      TabModel(
        page: const SettingsView(),
        icon: const Icon(AppIcons.settings),
        title: LocaleKeys.navigationTabs_advertiseTabTitle,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
