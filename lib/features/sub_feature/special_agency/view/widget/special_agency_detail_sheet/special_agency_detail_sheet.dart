part of '../../special_agency_view.dart';

abstract final class _InstitutionSheet {
  static Future<void> show(
    BuildContext context,
    SpecialAgencyModel institution,
    String district,
  ) async {
    await DetailSheet.show(
      context: context,
      children: [
        _SheetHeader(institution: institution, district: district),
        _SheetDetails(institution: institution),
        _SheetActions(institution: institution),
      ],
    );
  }
}

final class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.institution, required this.district});

  final SpecialAgencyModel institution;
  final String district;

  @override
  Widget build(BuildContext context) {
    final name = institution.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        if (name != null && name.isNotEmpty) GeneralContentTitle(value: name),
        if (district.isNotEmpty) GeneralContentSmallTitle(value: district),
      ],
    );
  }
}

final class _SheetDetails extends StatelessWidget {
  const _SheetDetails({required this.institution});

  final SpecialAgencyModel institution;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        if (institution.phone != null)
          DetailActionRow(
            labelKey: LocaleKeys.specialAgency_agencyNumber,
            value: institution.phone!,
            icon: AppIcons.phone,
            primaryIcon: AppIcons.phone,
            primaryTooltipKey: LocaleKeys.general_action_call,
            onPrimary: () => LinkActions.call(context, institution.phone),
            accent: context.appColors.navy,
          ),
        if (institution.address != null)
          DetailActionRow(
            labelKey: LocaleKeys.specialAgency_agencyAddress,
            value: institution.address!,
            icon: AppIcons.location,
            primaryIcon: AppIcons.directions,
            primaryTooltipKey: LocaleKeys.general_action_directions,
            onPrimary: () => LinkActions.directions(
              context,
              institution.latLong.coordinates,
            ),
            accent: context.appColors.navy,
          ),
      ],
    );
  }
}

final class _SheetActions extends StatelessWidget {
  const _SheetActions({required this.institution});

  final SpecialAgencyModel institution;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTopLow(),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: GeneralButtonV2.active(
              action: () => LinkActions.call(context, institution.phone),
              label: LocaleKeys.general_action_call.tr(),
              icon: AppIcons.phone,
              backgroundColor: context.appColors.navy,
            ),
          ),
          Expanded(
            child: OutlineActionButton(
              labelKey: LocaleKeys.general_action_directions,
              icon: AppIcons.directions,
              onPressed: () => LinkActions.directions(
                context,
                institution.latLong.coordinates,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
