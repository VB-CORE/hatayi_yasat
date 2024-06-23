import 'package:flutter/material.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/home/view/home_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/main/settings/view/settings_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

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
        title: LocaleKeys.navigationTabs_home,
      ),
      TabModel(
        page: const EventView(),
        icon: const Icon(AppIcons.event),
        title: LocaleKeys.navigationTabs_activities,
      ),
      TabModel(
        page: const NewsJobsView(),
        icon: const Icon(AppIcons.textSnippet),
        title: LocaleKeys.navigationTabs_news,
      ),
      TabModel(
        page: const SettingsView(),
        icon: const Icon(AppIcons.settings),
        title: LocaleKeys.navigationTabs_settings,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
