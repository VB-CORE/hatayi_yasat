import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/news_jobs/provider/news_jobs_provider.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:vbaseproject/product/widget/card/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

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
      title: LocaleKeys.notFound_news,
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
