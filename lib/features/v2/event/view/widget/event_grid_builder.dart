part of '../event_view.dart';

// TODO: Fix => Gerçek model ile güncellenecek.
@immutable
final class _EventGridBuilder extends StatelessWidget {
  const _EventGridBuilder();

  @override
  Widget build(BuildContext context) {
    final dummyData = CampaignModel(
      name: 'Test Event',
      topic: 'Buluşma',
      description: 'Test açıklama',
      publisher: 'User',
      expireDate: DateTime.now(),
      photo:
          'https://fastly.picsum.photos/id/420/720/720.jpg?hmac=9le6YkBe6BgtPkTUQHVTCbw1X6hb4MeRkiVlS04cT7k',
    );
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
          campaignModel: dummyData,
        );
      },
    );
  }
}
