part of '../filter_search_view.dart';

final class _FilterSearchTowns extends ConsumerWidget {
  const _FilterSearchTowns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = ref.read(ProductProvider.provider).townItemsWithAll;
    return ListView.builder(
      itemCount: towns.length,
      itemBuilder: (BuildContext context, int index) {
        return GeneralCheckBox(
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
