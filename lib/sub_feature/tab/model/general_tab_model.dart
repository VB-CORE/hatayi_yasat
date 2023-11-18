import 'package:flutter/material.dart';
import 'package:vbaseproject/features/advertise/view/advertise_view.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/view/campaigns_view.dart';
import 'package:vbaseproject/features/home_module/home/view/home_view.dart';
import 'package:vbaseproject/features/news_module/news/view/news_view.dart';

@immutable
final class GeneralTabModel {
  const GeneralTabModel({required this.icon, required this.page});

  final Widget icon;
  final Widget page;

  static const List<GeneralTabModel> tabItems = [
    GeneralTabModel(
      page: HomeView(),
      icon: Icon(Icons.home),
    ),
    GeneralTabModel(
      page: CampaignsView(),
      icon: Icon(Icons.event_available),
    ),
    GeneralTabModel(
      page: NewsView(),
      icon: Icon(Icons.text_snippet),
    ),
    GeneralTabModel(
      page: AdvertiseView(),
      icon: Icon(Icons.settings),
    ),
  ];
}
