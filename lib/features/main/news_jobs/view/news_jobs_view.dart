import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/view/groups_view.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/sub_view/tab_news_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

part 'widget/news_jobs_tab_bar.dart';
part 'widget/news_jobs_tab_view.dart';

enum NewsEventJobTabs {
  news,
  event,
  groups,
  ;

  String get title {
    switch (this) {
      case NewsEventJobTabs.news:
        return LocaleKeys.navigationTabs_news.tr();
      case NewsEventJobTabs.groups:
        return LocaleKeys.navigationTabs_groups.tr();
      case NewsEventJobTabs.event:
        return LocaleKeys.navigationTabs_activities.tr();
    }
  }
}

final class NewsEventJobsView extends StatelessWidget {
  const NewsEventJobsView({super.key});
  @override
  Widget build(BuildContext context) {
    final isAuthenticated =
        ProviderScope.containerOf(context).read(authViewModelProvider)
            is Authenticated;
    final visibleTabs = isAuthenticated
        ? NewsEventJobTabs.values
        : NewsEventJobTabs.values
              .where((tab) => tab != NewsEventJobTabs.groups)
              .toList();

    return DefaultTabController(
      length: visibleTabs.length,
      child: Scaffold(
        body: Column(
          children: [
            _NewsEventJobsTabBar(tabs: visibleTabs),
            Expanded(child: _NewsEventJobsTabView(tabs: visibleTabs)),
          ],
        ),
      ),
    );
  }
}
