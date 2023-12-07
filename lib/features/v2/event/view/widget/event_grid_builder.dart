part of '../event_view.dart';

// TODO: Fix => Gerçek model ile güncellenecek.
final class _EventGridBuilder extends StatelessWidget {
  const _EventGridBuilder();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const PagePadding.onlyTopMedium(),
      itemCount: 10,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: WidgetSizes.spacingSs,
        mainAxisSpacing: WidgetSizes.spacingS,
        mainAxisExtent: context.sized.dynamicHeight(0.24),
      ),
      itemBuilder: (BuildContext context, int index) {
        return EventCard(
          onTap: () {},
          campaignModel: CampaignEmptyModel.empty,
        );
      },
    );
  }
}
