part of '../login_view.dart';

final class _LoginAppHeader extends StatelessWidget {
  const _LoginAppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: WidgetSizes.spacingXxl9,
          child: DecoratedBox(
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
            child: Padding(
              padding: const PagePadding.allVeryLow(),
              child: Assets.icons.icApp.image(),
            ),
          ),
        ),
        const EmptyBox.middleWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentTitle(
              value: LocaleKeys.project_name.tr(),
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
