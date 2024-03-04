part of 'advertisement_slider.dart';

final class _AdvertisementItem extends StatelessWidget {
  const _AdvertisementItem(this.item);

  final AdBoardModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => _onPressed(context),
      child: CustomNetworkImage(
        imageUrl: item.image,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    final link = item.link;
    if (link.ext.isNullOrEmpty) {
      return;
    }

    return showModalBottomSheet<void>(
      builder: (_) => _AdvertisementDetailView(item),
      context: context,
    );
  }
}
