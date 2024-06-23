import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_jobs_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_news_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

part 'widget/news_jobs_tab_bar.dart';
part 'widget/news_jobs_tab_view.dart';

enum NewsJobTabs {
  news,
  jobs;

  String get title {
    switch (this) {
      case NewsJobTabs.news:
        return LocaleKeys.navigationTabs_news.tr();
      case NewsJobTabs.jobs:
        return LocaleKeys.navigationTabs_advertise.tr();
    }
  }
}

final class NewsJobsView extends StatefulWidget {
  const NewsJobsView({super.key});
  @override
  State<NewsJobsView> createState() => _NewsJobsViewState();
}

class _NewsJobsViewState extends State<NewsJobsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NewsJobTabs.values.length,
      child: const Scaffold(
        body: Column(
          children: [
            _NewsJobsTabBar(),
            Expanded(child: _NewsJobsTabView()),
          ],
        ),
      ),
    );
  }
}
