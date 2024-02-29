import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_jobs_provider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/news_model_copy.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:lifeclient/product/widget/card/index.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

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
      emptyBuilder: (context) {
        return const GeneralNotFoundWidget(
          title: LocaleKeys.notFound_news,
        );
      },
      itemBuilder: (context, model) {
        return NewsCard(
          item: model,
          onTap: () {
            NewsDetailRoute($extra: NewsModelCopy.fromNewsModel(model))
                .push<NewsDetailRoute>(context);
          },
        );
      },
      onRetry: () {},
    );
  }
}
