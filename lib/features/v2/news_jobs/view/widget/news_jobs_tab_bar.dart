part of '../news_jobs_view.dart';

@immutable
final class _NewsJobsTabBar extends StatelessWidget {
  const _NewsJobsTabBar();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: 'News2'),
        Tab(text: 'Jobs'),
      ],
    );
  }
}
