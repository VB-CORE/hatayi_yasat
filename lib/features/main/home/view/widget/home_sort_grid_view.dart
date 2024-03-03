part of '../home_view.dart';

final class _HomeSortGridView extends StatelessWidget {
  const _HomeSortGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _ViewDesignButton(),
        _SortPlaceButton(),
      ],
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
