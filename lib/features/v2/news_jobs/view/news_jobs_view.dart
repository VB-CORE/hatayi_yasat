import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/news_jobs/view/sub_view/index.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/title/general_big_title.dart';

part 'widget/news_jobs_tab_bar.dart';
part 'widget/news_jobs_tab_title.dart';
part 'widget/news_jobs_tab_view.dart';

final class NewsJobsView extends StatefulWidget {
  const NewsJobsView({super.key});
  @override
  State<NewsJobsView> createState() => _NewsJobsViewState();
}

class _NewsJobsViewState extends State<NewsJobsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const _NewsJobsTabBar().ext.sliver,
              ];
            },
            body: const _NewsJobsTabView(),
          ),
        ),
      ),
    );
  }
}
