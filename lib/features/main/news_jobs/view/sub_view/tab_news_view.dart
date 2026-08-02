import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_jobs_provider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/news_model_copy.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/card/index.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

@immutable
final class TabNewsView extends ConsumerStatefulWidget {
  const TabNewsView({super.key});

  @override
  ConsumerState<TabNewsView> createState() => _TabNewsViewState();
}

class _TabNewsViewState extends ConsumerState<TabNewsView> {
  int _refreshKey = 0;

  void _retry() {
    setState(() => _refreshKey++);
  }

  @override
  Widget build(BuildContext context) {
    final query = ref
        .read(newsJobsProviderProvider.notifier)
        .fetchNewsCollectionReference();

    return RefreshIndicator(
      onRefresh: () async => _retry(),
      child: KeyedSubtree(
        key: ValueKey(_refreshKey),
        child: GeneralFirestoreListView(
          query: query,
          emptyBuilder: (context) {
            return GeneralNotFoundWidget(
              title: LocaleKeys.notFound_news.tr(),
              onRefresh: _retry,
            );
          },
          itemBuilder: (context, model) {
            return NewsCard(
              item: model,
              onTap: () {
                NewsDetailRoute(
                  $extra: NewsModelCopy.fromNewsFeedModel(model),
                  id: model.documentId,
                ).push<void>(context);
              },
            );
          },
          onRetry: _retry,
        ),
      ),
    );
  }
}
