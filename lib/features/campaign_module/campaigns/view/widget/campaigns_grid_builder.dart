part of '../campaigns_view.dart';

class _GridBuilder extends StatelessWidget {
  const _GridBuilder({required this.items});
  final List<CampaignModel> items;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverGrid.builder(
        gridDelegate: _gridDelegate(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CampaignPlaceCard(
            item: items[index],
            onTap: () => context.route.navigateToPage(
              CampaignDetailsView(
                campaignModel: items[index],
              ),
            ),
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
