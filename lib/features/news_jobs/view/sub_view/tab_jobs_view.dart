import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_jobs/provider/news_jobs_provider.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/card/index.dart';
import 'package:vbaseproject/product/widget/general/general_not_found_widget.dart';

@immutable
final class TabJobsView extends ConsumerWidget {
  const TabJobsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(newsJobsProviderProvider.notifier)
        .fetchJobsCollectionReference();

    return GeneralFirestoreListView(
      query: query,
      emptyBuilder: (context) {
        return const GeneralNotFoundWidget(
          title: LocaleKeys.notFound_advertise,
        );
      },
      itemBuilder: (context, model) {
        return AdvertisePlaceCard(
          item: model,
        );
      },
      onRetry: () {},
    );
  }
}
