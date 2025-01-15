part of '../home_view.dart';

final class _HomePlacesArea extends ConsumerWidget {
  const _HomePlacesArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query =
        ref.read(homeViewModelProvider.notifier).fetchApprovedCollectionQuery();

    return FirestoreSliverListView(
      emptyBuilder: (context) => GeneralNotFoundWidget(
        title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
        onRefresh: () async {
          final result = await query.get();
          print(result.docs.length);
        },
      ),
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
          ),
        );
      },
      onRetry: () {},
    );
  }
}
