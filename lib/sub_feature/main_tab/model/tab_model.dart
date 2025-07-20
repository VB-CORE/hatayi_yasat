import 'package:flutter/material.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/home/view/home_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';
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
        page: const NewsEventJobsView(),
        icon: const Icon(AppIcons.community),
        title: LocaleKeys.navigationTabs_community,
      ),
      TabModel(
        page: const EventView(),
        icon: const Icon(AppIcons.community),
        title: LocaleKeys.navigationTabs_activities,
      ),
      TabModel(
        page: const FavoriteView(),
        icon: const Icon(AppIcons.favorite),
        title: LocaleKeys.navigationTabs_favorite,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
