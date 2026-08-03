part of '../news_jobs_view.dart';

@immutable
final class _NewsEventJobsTabView extends StatelessWidget {
  const _NewsEventJobsTabView({required this.tabs});

  final List<NewsEventJobTabs> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: tabs.map(_pageFor).toList(),
    );
  }

  Widget _pageFor(NewsEventJobTabs tab) {
    switch (tab) {
      case NewsEventJobTabs.news:
        return const TabNewsView();
      case NewsEventJobTabs.event:
        return const EventView();
      case NewsEventJobTabs.groups:
        return const GroupsView();
    }
  }
}
