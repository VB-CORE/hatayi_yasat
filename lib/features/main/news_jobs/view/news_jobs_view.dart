import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_jobs_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_news_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

part 'widget/news_jobs_tab_bar.dart';
part 'widget/news_jobs_tab_view.dart';

enum NewsEventJobTabs {
  news,
  event,
  jobs,
  ;

  String get title {
    switch (this) {
      case NewsEventJobTabs.news:
        return LocaleKeys.navigationTabs_news.tr();
      case NewsEventJobTabs.jobs:
        return LocaleKeys.navigationTabs_advertise.tr();
      case NewsEventJobTabs.event:
        return LocaleKeys.navigationTabs_activities.tr();
    }
  }
}

final class NewsEventJobsView extends StatefulWidget {
  const NewsEventJobsView({super.key});
  @override
  State<NewsEventJobsView> createState() => _NewsEventJobsViewState();
}

class _NewsEventJobsViewState extends State<NewsEventJobsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NewsEventJobTabs.values.length,
      child: const Scaffold(
        body: Column(
          children: [
            _NewsEventJobsTabBar(),
            Expanded(child: _NewsEventJobsTabView()),
          ],
        ),
      ),
    );
  }
}
