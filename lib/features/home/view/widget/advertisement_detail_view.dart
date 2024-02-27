part of '../home_view.dart';

final class _AdvertisementDetailView extends StatelessWidget {
  const _AdvertisementDetailView(this.item);

  final AdvertisementModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GeneralButtonV2.active(
            action: () {},
            //TODO: localize
            label: 'Linki Aç',
          ),
          Padding(
            padding: const PagePadding.onlyTop(),
            child: GeneralButtonV2.active(
              action: () {},
              //TODO: localize
              label: 'Paylaş',
            ),
          ),
        ],
      ),
    );
  }
}
