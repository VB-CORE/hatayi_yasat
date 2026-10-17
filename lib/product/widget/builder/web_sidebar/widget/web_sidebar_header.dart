part of '../web_sidebar.dart';

final class _WebSidebarHeader extends StatelessWidget {
  const _WebSidebarHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalAllNormal(),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Assets.icons.icAppTransparent.image(
            width: WidgetSizes.spacingXxl4,
            height: WidgetSizes.spacingXxl4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Text(
                  LocaleKeys.project_name.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.titleLg.copyWith(
                    color: context.general.colorScheme.onSurface,
                  ),
                ),
                Text(
                  LocaleKeys.splash_tagline.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.micro.copyWith(
                    color: context.general.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
