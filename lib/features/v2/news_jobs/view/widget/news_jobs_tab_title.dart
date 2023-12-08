part of '../news_jobs_view.dart';

@immutable
final class _NewsJobsTabTitleView extends StatelessWidget {
  const _NewsJobsTabTitleView();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.sized.dynamicHeight(.1),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const PagePadding.onlyLeft(),
        title: GeneralBigTitle(
          LocaleKeys.navigationTabs_newsTabTitle.tr(),
        ),
      ),
    );
  }
}
