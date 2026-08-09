part of '../special_agency_view.dart';

final class _InstitutionRow extends StatelessWidget {
  const _InstitutionRow({required this.institution, required this.district});

  final SpecialAgencyModel institution;
  final String district;

  static const double _iconSize = WidgetSizes.spacingXxl3;

  @override
  Widget build(BuildContext context) {
    final name = institution.name;
    final address = institution.address;

    return Semantics(
      button: true,
      label: institution.name,
      child: InkWell(
        onTap: () => _InstitutionSheet.show(context, institution, district),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: WidgetSizes.spacingXxl5,
          ),
          padding:
              const PagePadding.horizontalLowSymmetric() +
              const PagePadding.vertical8Symmetric(),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: context.appColors.ink100),
            ),
          ),
          child: Row(
            spacing: AppSpacing.sm,
            children: [
              const _KindIcon(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name != null && name.isNotEmpty)
                      GeneralContentSubTitle(
                        value: name,
                        fontWeight: FontWeight.w700,
                        color: context.appColors.ink800,
                      ),
                    if (address != null && address.isNotEmpty)
                      GeneralContentSmallTitle(value: address),
                  ],
                ),
              ),
              Icon(AppIcons.rightSelect, color: context.appColors.ink300),
            ],
          ),
        ),
      ),
    );
  }
}

final class _KindIcon extends StatelessWidget {
  const _KindIcon();

  static const double _backgroundOpacity = 0.08;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _InstitutionRow._iconSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.navy.withValues(alpha: _backgroundOpacity),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Center(
          child: Icon(
            AppIcons.accountBalance,
            color: context.appColors.navy,
            size: AppIconSizes.medium,
          ),
        ),
      ),
    );
  }
}
