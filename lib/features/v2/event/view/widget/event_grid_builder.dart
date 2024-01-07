part of '../event_view.dart';

@immutable
final class _EventGridBuilder extends ConsumerWidget {
  const _EventGridBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(eventViewModelProvider.notifier)
        .fetchCampaignCollectionReference();

    return FirestoreGridView(
      query: query,
      padding: const PagePadding.onlyTopMedium() +
          const PagePadding.onlyBottomHigh(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: WidgetSizes.spacingSs,
        mainAxisSpacing: WidgetSizes.spacingS,
        mainAxisExtent: context.sized.dynamicHeight(0.24),
      ),
      itemBuilder: (context, doc) {
        final model = doc.data();
        if (model == null) return const SizedBox.shrink();
        return EventCard(
          onTap: () {
            EventDetailsRoute($extra: model).push<EventDetailsRoute>(context);
          },
          campaignModel: model,
        );
      },
    );
  }
}
