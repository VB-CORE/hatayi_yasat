part of '../special_agency_view.dart';

@immutable
final class _SpecialAgencyListBuilder extends ConsumerWidget {
  const _SpecialAgencyListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(specialAgencyViewModelProvider.notifier)
        .fetchAgencyCollectionReference();

    return GeneralFirestoreListView(
      query: query,
      title: LocaleKeys.notFound_specialAgency,
      itemBuilder: (context, model) {
        return Padding(
          padding: const PagePadding.vertical6Symmetric(),
          child: SpecialAgencyCard(model: model),
        );
      },
      onRetry: () {},
    );
  }
}
