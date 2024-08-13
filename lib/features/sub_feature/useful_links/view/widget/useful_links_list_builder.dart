part of '../useful_links_view.dart';

@immutable
final class _UsefulLinksListBuilder extends ConsumerWidget {
  const _UsefulLinksListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(usefulLinksViewModelProvider.notifier)
        .fetchLinksCollectionReference();

    return GeneralFirestoreListView(
      query: query,
      itemBuilder: (context, model) {
        return Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: UsefulLinkCard(model: model),
        );
      },
      onRetry: () {},
      emptyBuilder: (BuildContext context) {
        return GeneralNotFoundWidget(
          title: LocaleKeys.notFound_usefulLinks.tr(),
        );
      },
    );
  }
}
