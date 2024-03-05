part of '../place_search_delegate.dart';

class _PlaceSearchResponseResult extends StatelessWidget {
  const _PlaceSearchResponseResult({
    required this.items,
    required this.onSelected,
    required this.query,
  });

  final List<SearchResponse> items;
  final ValueChanged<SearchResponse> onSelected;
  final String query;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _EmptyResponseResult();

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          leading: FaIcon(
            FontAwesomeIcons.store,
            size: context.sized.normalValue,
          ),
          title: Text(items[index].name),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () {
            onSelected.call(items[index]);
          },
        );
      },
    );
  }
}
