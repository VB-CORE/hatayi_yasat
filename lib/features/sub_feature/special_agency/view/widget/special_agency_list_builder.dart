part of '../special_agency_view.dart';

final class _SpecialAgencyListBuilder extends ConsumerStatefulWidget {
  const _SpecialAgencyListBuilder();

  @override
  ConsumerState<_SpecialAgencyListBuilder> createState() =>
      __SpecialAgencyListBuilderState();
}

final class __SpecialAgencyListBuilderState
    extends ConsumerState<_SpecialAgencyListBuilder>
    with AppProviderMixin, _SpecialAgencyListBuilderMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: townNamesAndAgency.length,
      itemBuilder: (context, index) {
        final townName = townNamesAndAgency.keys.elementAt(index);
        final agencyList = townNamesAndAgency[townName];

        if (agencyList == null) {
          return const EmptyBox.smallHeight();
        }

        return GeneralExpansionTile(
          pageTitle: townName,
          children: agencyList
              .map((agency) => _SpecialAgencyDetailListTile(agency: agency))
              .toList(),
        );
      },
    );
  }
}

final class _SpecialAgencyDetailListTile extends StatelessWidget {
  const _SpecialAgencyDetailListTile({required this.agency});
  final SpecialAgencyModel agency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        agency.name ?? '',
        style: context.general.textTheme.titleMedium,
      ),
      trailing: const Icon(AppIcons.rightArrow, size: AppIconSizes.medium),
      onTap: () async {
        await SpecialAgencyDetailSheet.show(context, agency);
      },
    );
  }
}

mixin _SpecialAgencyListBuilderMixin
    on
        ConsumerState<_SpecialAgencyListBuilder>,
        AppProviderMixin<_SpecialAgencyListBuilder> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_init);
  }

  Future<void> _init() async {
    final towns = productState.townItems;
    await ref
        .read(specialAgencyViewModelProvider.notifier)
        .fetchAgencyCollectionReference(towns);
  }

  SpecialAgencyState get _state => ref.watch(specialAgencyViewModelProvider);
  Map<String, List<SpecialAgencyModel>> get townNamesAndAgency =>
      _state.townNamesAndAgency;
}
