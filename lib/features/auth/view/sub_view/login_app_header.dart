part of '../login_view.dart';

final class _LoginAppHeader extends StatelessWidget {
  const _LoginAppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: CustomRadius.large,
          child: CustomShimmer(
            child: SizedBox.square(
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
          ),
        ),
        const EmptyBox.middleWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: WidgetSizes.spacingXSSs,
          children: [
            Text(
              LocaleKeys.project_name.tr(),
              style: AppText.titleLg.copyWith(
                color: context.appColors.white,
                fontWeight: .bold,
              ),
            ),
            Text(
              LocaleKeys.auth_tagline.tr(),
              style: AppText.bodySm.copyWith(
                color: context.appColors.white,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
