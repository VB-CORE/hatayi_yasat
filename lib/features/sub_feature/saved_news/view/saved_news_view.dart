import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/saved_news/provider/saved_news_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/news_model_copy.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/card/index.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class SavedNewsView extends ConsumerWidget {
  const SavedNewsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedNewsViewModelProvider);

    return GeneralScaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.savedNews_title.tr()),
      ),
      body: CustomScrollView(
        slivers: [
          if (state.isFetching)
            const SliverToBoxAdapter(
              child: GeneralShimmer(height: CustomShimmerHeight.small),
            )
          else if (state.isError)
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: GeneralNotFoundWidget(
                  title: LocaleKeys.savedNews_error.tr(),
                  onRefresh: () =>
                      ref.read(savedNewsViewModelProvider.notifier).retry(),
                ),
              ),
            )
          else if (state.newsItems.isEmpty)
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: GeneralNotFoundWidget(
                  title: LocaleKeys.savedNews_empty.tr(),
                ),
              ),
            )
          else
            SliverList.builder(
              itemCount: state.newsItems.length,
              itemBuilder: (context, index) {
                final model = state.newsItems[index];
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
            ),
        ],
      ),
    );
  }
}
