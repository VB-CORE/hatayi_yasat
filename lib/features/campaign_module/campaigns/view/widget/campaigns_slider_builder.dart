part of '../campaigns_view.dart';

class _SliderBuilder extends StatelessWidget {
  const _SliderBuilder({required this.items});
  final List<CampaignModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomBannerSlider(
        sliderItems: items
            .map(
              (e) => SliderModel(
                title: e.name ?? '',
                imageUrl: e.coverPhoto ?? '',
              ),
            )
            .toList(),
        onTapped: (index) {
          context.route.navigateToPage(
            CampaignDetailsView(
              campaignModel: items[index],
            ),
          );
        },
      ),
    );
  }
}
