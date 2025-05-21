part of '../filter_search_view.dart';

final class _FilterSearchTowns extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchTowns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = productProvider(ref).regionalTowns;

    final selectedItems = ref.watch(filterWithSearchProvider).selectedTowns;
    return ProductScrollBar(
      child: ListView.builder(
        itemCount: towns.length,
        itemBuilder: (BuildContext context, int index) {
          return GeneralCheckBox(
            value: selectedItems.contains(towns[index].toTownModel),
            title: towns[index].displayName,
            onUpdate: (value) {
              ref
                  .read(filterWithSearchProvider.notifier)
                  .updateSelectedDistrict(towns[index].toTownModel);
            },
          );
        },
      ),
    );
  }
}
