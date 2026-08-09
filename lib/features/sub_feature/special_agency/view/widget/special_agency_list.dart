part of '../special_agency_view.dart';

final class _SpecialAgencyList extends ConsumerWidget {
  const _SpecialAgencyList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townNamesAndAgency = ref.watch(
      specialAgencyViewModelProvider.select(
        (state) => state.townNamesAndAgency,
      ),
    );
    final townNames = townNamesAndAgency.keys.toList();

    return ListView.builder(
      padding:
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.vertical8Symmetric(),
      itemCount: townNames.length,
      itemBuilder: (context, index) {
        final townName = townNames[index];
        final agencyList = townNamesAndAgency[townName];

        if (agencyList == null) return const EmptyBox.smallHeight();

        return GeneralExpansionTile(
          title: townName,
          subtitle: LocaleKeys.specialAgency_groupCount.tr(
            args: [agencyList.length.toString()],
          ),
          leadingIcon: AppIcons.city,
          initiallyExpanded: index == 0,
          children: agencyList
              .map(
                (agency) =>
                    _InstitutionRow(institution: agency, district: townName),
              )
              .toList(),
        );
      },
    );
  }
}
