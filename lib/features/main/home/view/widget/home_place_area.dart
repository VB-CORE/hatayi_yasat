part of '../home_view.dart';

final class _HomePlaceArea extends ConsumerStatefulWidget {
  const _HomePlaceArea();

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
      emptyBuilder: (context) => GeneralNotFoundWidget(
        title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
        onRefresh: () async {
          await query.get();
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
