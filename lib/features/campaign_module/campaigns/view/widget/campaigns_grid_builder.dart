part of '../campaigns_view.dart';

class _GridBuilder extends StatelessWidget {
  const _GridBuilder({required this.items, required this.gridDelegate});
  final List<CampaignModel> items;
  final SliverGridDelegate gridDelegate;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverGrid.builder(
        gridDelegate: gridDelegate,
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
}
