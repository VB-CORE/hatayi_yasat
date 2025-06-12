part of '../news_jobs_view.dart';

@immutable
final class _NewsEventJobsTabView extends StatelessWidget {
  const _NewsEventJobsTabView();

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        TabNewsView(),
        TabJobsView(),
        EventView(),
      ],
    );
  }
}
