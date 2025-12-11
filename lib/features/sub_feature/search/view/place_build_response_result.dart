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
      padding: const PagePadding.horizontalSymmetric(),
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        final item = items[index];
        final image = item.image.isEmpty ? item.images.firstOrNull : item.image;
        return ListTile(
          leading:
              image == null
                  ? null
                  : SizedBox.square(
                    dimension: WidgetSizes.spacingXxl8,
                    child: CustomNetworkImage(
              imageUrl: image),
                  ),
          title: Text(item.name),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralContentSubTitle(value: LocaleKeys.button_more.tr()),
              const Icon(Icons.chevron_right_outlined),
            ],
          ),
          onTap: () {
            onSelected.call(items[index]);
          },
        );
      },
    );
  }
}
