import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/news_jobs/provider/news_jobs_provider.dart';
import 'package:vbaseproject/product/widget/card/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

final class TabJobsView extends ConsumerWidget {
  const TabJobsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(newsJobsProviderProvider.notifier)
        .fetchNewsCollectionReferance();
    return GeneralFirestoreListView(
      query: query,
      itemBuilder: (context, model) {
        return NewsCard(
          item: model,
          onTap: () {},
        );
      },
      onRetry: () {},
    );
  }
}
