import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_jobs_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_news_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

part 'widget/news_jobs_tab_bar.dart';
part 'widget/news_jobs_tab_view.dart';

final class NewsJobsView extends StatefulWidget {
  const NewsJobsView({super.key});
  @override
  State<NewsJobsView> createState() => _NewsJobsViewState();
}

class _NewsJobsViewState extends State<NewsJobsView> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
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
