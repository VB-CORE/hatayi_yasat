part of '../home_view.dart';

final class _HomePlacesArea extends ConsumerWidget {
  const _HomePlacesArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(homeViewModelProvider.notifier)
        .fetchApprovedCollectionReference();

    return FirestoreSliverListView(
      query: query,
      isGridDesign: ref.watch(homeViewModelProvider).isGridView,
      itemGridBuilder: (context, model) {
        return Padding(
          padding: const PagePadding.onlyBottom(),
          child: GeneralPlaceGridCard(
            onCardTap: () {
              PlaceDetailRoute($extra: model, id: model.documentId)
                  .push<PlaceDetailRoute>(context);
            },
            storeModel: model,
            onBookmarkIconTap: () {},
          ),
        );
      },
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
