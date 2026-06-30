part of '../login_view.dart';

final class _LoginAppHeader extends StatelessWidget {
  const _LoginAppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.general.colorScheme.surface,
            borderRadius: CustomRadius.large,
            boxShadow: [
              BoxShadow(
                color: context.general.colorScheme.shadow.withValues(
                  alpha: 0.12,
                ),
                blurRadius: WidgetSizes.spacingS,
                offset: const Offset(kZero, WidgetSizes.spacingXxs),
              ),
            ],
          ),
          padding: const PagePadding.allVeryLow(),
          child: Assets.icons.icApp.image(),
        ),
        const EmptyBox.middleWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentTitle(
              value: LocaleKeys.project_name.tr(),
              fontWeight: FontWeight.bold,
              color: ColorsCustom.sambacus,
            ),
            GeneralContentSmallTitle(
              value: LocaleKeys.auth_tagline.tr(),
              fontWeight: .w600,
              color: ColorsCustom.royalPeacock,
            ),
          ],
        ),
      ],
    );
  }
}
