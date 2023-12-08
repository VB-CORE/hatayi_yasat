part of '../news_jobs_view.dart';

@immutable
final class _NewsJobsTabView extends StatelessWidget {
  const _NewsJobsTabView();

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [TabJobsView(), TabNewsView()],
    );
  }
}
