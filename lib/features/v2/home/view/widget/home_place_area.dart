part of '../home_view.dart';

final class _HomePlacesArea extends ConsumerWidget {
  const _HomePlacesArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query =
        ref.read(homeViewModelProvider.notifier).fetchJobsCollectionReference();

    return FirestoreSliverListView(
      query: query,
      itemBuilder: (context, model) {
        return Padding(
          padding: const PagePadding.onlyBottom(),
          child: GeneralPlaceCard(
            onCardTap: () {
              PlaceDetailRoute($extra: model, id: model.documentId)
                  .push<PlaceDetailRoute>(context);
            },
            storeModel: model,
            onBookmarkIconTap: () {},
          ),
        );
      },
      onRetry: () {},
    );
  }
}
