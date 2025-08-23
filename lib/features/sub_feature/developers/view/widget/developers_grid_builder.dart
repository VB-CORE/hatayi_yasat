part of '../developers_view.dart';

@immutable
final class _DevelopersGridBuilder extends ConsumerWidget {
  const _DevelopersGridBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryActive = ref
        .read(developersViewModelProvider.notifier)
        .fetchDevelopersCollectionReference()
        .where(FirebaseQueryItems.active.name, isEqualTo: true);

    final queryInactive = ref
        .read(developersViewModelProvider.notifier)
        .fetchDevelopersCollectionReference()
        .where(FirebaseQueryItems.active.name, isEqualTo: false);

    return CustomScrollView(
      slivers: [
        _GeneralGridBuilder(query: queryActive),
        const _SubTitle(),
        _GeneralGridBuilder(query: queryInactive),
      ],
    );
  }
}

final class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Divider(
              color: context.general.colorScheme.primary,
            ),
            Text(
              LocaleKeys.settings_inactiveDevelopers.tr(),
              style: context.general.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: context.general.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _GeneralGridBuilder extends ConsumerWidget {
  const _GeneralGridBuilder({required this.query});
  final Query<DeveloperModel?> query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FirestoreGridSliverView(
      query: query,
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
