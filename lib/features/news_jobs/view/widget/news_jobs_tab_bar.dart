part of '../news_jobs_view.dart';

@immutable
final class _NewsJobsTabBar extends StatelessWidget {
  const _NewsJobsTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(text: LocaleKeys.navigationTabs_newsTabTitle.tr()),
        Tab(text: LocaleKeys.navigationTabs_advertiseTabTitle.tr()),
      ],
    );
  }
}
