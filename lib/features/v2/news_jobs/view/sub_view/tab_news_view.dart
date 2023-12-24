import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/news_jobs/provider/news_jobs_provider.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:vbaseproject/product/widget/card/index.dart';
import 'package:vbaseproject/product/widget/general/list/general_firestore_list_view.dart';

@immutable
final class TabNewsView extends ConsumerWidget {
  const TabNewsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(newsJobsProviderProvider.notifier)
        .fetchNewsCollectionReference();

    return GeneralFirestoreListView(
      query: query,
      itemBuilder: (context, model) {
        return NewsCard(
          item: model,
          onTap: () {
            NewsDetailRoute($extra: model).push<NewsDetailRoute>(context);
          },
        );
      },
      onRetry: () {},
    );
  }
}
