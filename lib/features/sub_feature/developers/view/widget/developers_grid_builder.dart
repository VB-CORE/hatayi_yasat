part of '../developers_view.dart';

@immutable
final class _DevelopersGridBuilder extends ConsumerWidget {
  const _DevelopersGridBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(developersViewModelProvider.notifier)
        .fetchDevelopersCollectionReference();

    return FirestoreGridView(
      query: query,
      padding: const PagePadding.onlyTopMedium(),
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
        return DeveloperProfileCard(model: model);
      },
      emptyBuilder: (_) => GeneralNotFoundWidget(
        title: LocaleKeys.notFound_developers.tr(),
        onRefresh: () {},
      ),
    );
  }
}
