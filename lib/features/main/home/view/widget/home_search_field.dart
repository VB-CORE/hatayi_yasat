part of '../home_view.dart';

final class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: SliverAppBar(
        floating: true,
        pinned: true,
        titleSpacing: kZero,
        actions: const [
          _ViewDesignButton(),
          _SortPlaceButton(),
        ],
        title: InkWell(
          onTap: () async {
            await showSearch<SearchResponse>(
              context: context,
              delegate: PlaceSearchDelegate(),
            );
          },
          child: IgnorePointer(
            child: CustomSearchField(
              hint: LocaleKeys.home_search.tr(),
              onChange: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewDesignButton extends ConsumerWidget {
  const _ViewDesignButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedButton(
      isAnimated: ref.watch(homeViewModelProvider).isGridView,
      onPressed: () async {
        ref.read(homeViewModelProvider.notifier).changeHomeViewCardType();
      },
      icon: AnimatedIcons.list_view,
    );
  }
}

final class _SortPlaceButton extends ConsumerWidget {
  const _SortPlaceButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final currentType = ref.read(homeViewModelProvider).sortingType;
        final result = await GeneralSelectSheet.show(
          context,
          isDismissible: true,
          mainAxisSize: MainAxisSize.min,
          items: [
            SelectSheetModel(
              title: SortingTypes.newest.detail.tr(),
              id: SortingTypes.newest.name,
            ),
            SelectSheetModel(
              title: SortingTypes.oldest.detail.tr(),
              id: SortingTypes.oldest.name,
            ),
          ],
          initialItem: SelectSheetModel(title: '', id: currentType.name),
        );
        if (result == null) return;
        ref
            .read(homeViewModelProvider.notifier)
            .changeSortingType(SortingTypes.values.byName(result.id));
      },
      icon: const Icon(Icons.sort_by_alpha_outlined),
    );
  }
}
