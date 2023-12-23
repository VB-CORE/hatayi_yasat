import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/news_detail_view.dart';
import 'package:vbaseproject/features/v2/news_jobs/view/news_jobs_view.dart';

final class NewsJobsRoute extends GoRouteData {
  const NewsJobsRoute();
  static const route = TypedGoRoute<NewsJobsRoute>(
    path: 'newsJobs',
    name: 'News and Jobs',
    routes: [
      NewsDetailRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NewsJobsView();
}

final class NewsDetailRoute extends GoRouteData {
  NewsDetailRoute({required this.$extra});

  static const route = TypedGoRoute<NewsDetailRoute>(
    path: 'detail',
    name: 'News Details',
  );

  final NewsModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NewsDetailView(news: $extra);
}
