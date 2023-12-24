part of '../filter_search_view.dart';

final class _FilterSearchTowns extends ConsumerWidget {
  const _FilterSearchTowns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = ref.read(ProductProvider.provider).townItems;
    final selectedItems = ref.watch(filterWithSearchProvider).selectedTowns;
    return ListView.builder(
      itemCount: towns.length,
      itemBuilder: (BuildContext context, int index) {
        return GeneralCheckBox(
          value: selectedItems.contains(towns[index]),
          title: towns[index].displayName,
          onUpdate: (value) {
            ref
                .read(filterWithSearchProvider.notifier)
                .updateSelectedDistrict(towns[index]);
          },
        );
      },
    );
  }
}
