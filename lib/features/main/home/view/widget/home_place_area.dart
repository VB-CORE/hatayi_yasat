part of '../home_view.dart';

class _HomePlaceArea extends ConsumerStatefulWidget {
  const _HomePlaceArea({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __HomePlaceAreaState();
}

class __HomePlaceAreaState extends ConsumerState<_HomePlaceArea> {
  late final Query<StoreModel?> query;

  @override
  void initState() {
    super.initState();
    query =
        ref.read(homeViewModelProvider.notifier).fetchApprovedCollectionQuery();
  }

  @override
  Widget build(BuildContext context) {
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
