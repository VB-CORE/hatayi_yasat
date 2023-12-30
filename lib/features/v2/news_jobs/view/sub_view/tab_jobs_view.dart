import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/news_jobs/provider/news_jobs_provider.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/card/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

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
      title: LocaleKeys.notFound_advertise,
      itemBuilder: (context, model) {
        return AdvertisePlaceCard(
          item: model,
        );
      },
      onRetry: () {},
    );
  }
}
