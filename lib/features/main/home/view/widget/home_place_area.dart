part of '../home_view.dart';

final class _HomePlaceArea extends ConsumerStatefulWidget {
  const _HomePlaceArea();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __HomePlaceAreaState();
}

class __HomePlaceAreaState extends ConsumerState<_HomePlaceArea>
    with ProjectDependencyMixin, _HomePlaceAreaMixin {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeViewModelProvider);
    if (vm.isLoading) {
      return SliverToBoxAdapter(child: Assets.lottie.loadingGray.lottie());
    }
    if (vm.hasClientFilters) {
      return _ClientFilteredPlaceArea(
        query: query,
        isGridDesign: vm.isGridView,
        openNow: vm.openNow,
        favoritesOnly: vm.favoritesOnly,
      );
    }
    return FirestoreSliverListView(
      emptyBuilder: _placeEmptyWidget,
      query: query,
      isGridDesign: vm.isGridView,
      itemGridBuilder: _gridItem,
      itemBuilder: _listItem,
      onRetry: () {},
    );
  }

  Widget _placeEmptyWidget(BuildContext context) {
    return GeneralNotFoundWidget(
      title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
      onRefresh: () async {
        await query.get();
      },
    );
  }
}

Widget _gridItem(BuildContext context, StoreModel model) {
  return Semantics(
    identifier: 'place_grid_card_${model.name}',
    child: Padding(
      padding: const PagePadding.onlyBottom(),
      child: GeneralPlaceGridCard(
        onCardTap: () => _openDetail(context, model),
        storeModel: model,
      ),
    ),
  );
}

Widget _listItem(BuildContext context, StoreModel model) {
  return Padding(
    padding: const PagePadding.onlyBottom(),
    child: GeneralPlaceCard(
      onCardTap: () => _openDetail(context, model),
      storeModel: model,
    ),
  );
}

void _openDetail(BuildContext context, StoreModel model) {
  PlaceDetailRoute(
    $extra: model,
    id: model.documentId,
  ).push<PlaceDetailRoute>(context);
}

/// In-memory filtered list for the open-now / favorites axes, which have no
/// Firestore field. Loads a bounded page and filters via the view model.
final class _ClientFilteredPlaceArea extends ConsumerWidget {
  const _ClientFilteredPlaceArea({
    required this.query,
    required this.isGridDesign,
    required this.openNow,
    required this.favoritesOnly,
  });

  static const int _limit = 300;

  final Query<StoreModel?> query;
  final bool isGridDesign;
  final bool openNow;
  final bool favoritesOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<QuerySnapshot<StoreModel?>>(
      stream: query.limit(_limit).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SliverToBoxAdapter(child: Assets.lottie.loadingGray.lottie());
        }
        final models = snapshot.data!.docs
            .map((e) => e.data())
            .whereType<StoreModel>();
        final places = ref
            .read(homeViewModelProvider.notifier)
            .filterClientSide(
              models,
              openNow: openNow,
              favoritesOnly: favoritesOnly,
            );

        if (places.isEmpty) {
          return SliverToBoxAdapter(
            child: GeneralNotFoundWidget(
              title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
              onRefresh: () async {},
            ),
          );
        }

        if (isGridDesign) {
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.sm,
              mainAxisExtent: MediaQuery.sizeOf(context).height * 0.24,
            ),
            itemCount: places.length,
            itemBuilder: (context, index) => _gridItem(context, places[index]),
          );
        }

        return SliverList.builder(
          itemCount: places.length,
          itemBuilder: (context, index) => _listItem(context, places[index]),
        );
      },
    );
  }
}

mixin _HomePlaceAreaMixin
    on ProjectDependencyMixin, ConsumerState<_HomePlaceArea> {
  late Query<StoreModel?> query;

  @override
  void initState() {
    super.initState();
    _updateFetchQuery();
    ref
      ..listenManual(homeViewModelProvider, (previous, next) {
        if (next.isLoading) setState(_updateFetchQuery);
      })
      ..listenManual(productProviderState, (previous, next) {
        if (next.selectedCity != previous?.selectedCity) {
          setState(_updateFetchQuery);
        }
      });
  }

  void _updateFetchQuery() {
    query =
        ref.read(homeViewModelProvider.notifier).fetchApprovedCollectionQuery();
  }
}
