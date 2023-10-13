import 'package:flutter/material.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view/campaigns_view.dart';
import 'package:vbaseproject/features/home_module/home/view/home_view.dart';
import 'package:vbaseproject/features/news_module/news/view/news_view.dart';
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
        page: const CampaignsView(),
        icon: const Icon(Icons.campaign_outlined),
        title: LocaleKeys.navigationTabs_campaignsTabTitle,
      ),
      TabModel(
        page: const NewsView(),
        icon: const Icon(Icons.newspaper_outlined),
        title: LocaleKeys.navigationTabs_newsTabTitle,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
