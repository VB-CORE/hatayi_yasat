part of '../home_view.dart';

class _HomePlaceArea extends ConsumerStatefulWidget {
  const _HomePlaceArea({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __HomePlaceAreaState();
}

class __HomePlaceAreaState extends ConsumerState<_HomePlaceArea> {
  late Query<StoreModel?> query;

  @override
  void initState() {
    super.initState();
    _updateFetchQuery();
    ref.listenManual(homeViewModelProvider, (previous, next) {
      if (next.isLoading) _updateFetchQuery();
    });
  }

  void _updateFetchQuery() {
    query =
        ref.read(homeViewModelProvider.notifier).fetchApprovedCollectionQuery();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeViewModelProvider).isLoading;
    if (isLoading) {
      return const SliverToBoxAdapter(
        child: CircularProgressIndicator(),
      );
    }
    return FirestoreSliverListView(
      key: K.homeKeys.placesGridArea,
      emptyBuilder: (context) => GeneralNotFoundWidget(
        title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
        onRefresh: () async {
          await query.get();
        },
      ),
      query: query,
      isGridDesign: ref.watch(homeViewModelProvider).isGridView,
      itemGridBuilder: (context, model) {
        print('model: ${model.documentId}');
        return Padding(
          padding: const PagePadding.onlyBottom(),
          child: GeneralPlaceGridCard(
            key: K.homeKeys.placeCard(model.documentId),
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
