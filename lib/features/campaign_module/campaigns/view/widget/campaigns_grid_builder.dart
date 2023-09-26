part of '../campaigns_view.dart';

class _GridBuilder extends ConsumerWidget {
  const _GridBuilder({required this.items});
  final List<CampaignModel> items;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverGrid.builder(
        gridDelegate: _gridDelegate(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CampaignPlaceCard(
            item: items[index],
            onTap: () {},
          );
        },
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: AppConstants.kTwo,
      childAspectRatio: AppConstants.kThree / AppConstants.kFour,
    );
  }
}
