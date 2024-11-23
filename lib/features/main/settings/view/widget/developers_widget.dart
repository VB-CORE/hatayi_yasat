part of '../settings_view.dart';

@immutable
final class _DevelopersWidget extends StatelessWidget {
  const _DevelopersWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.general.colorScheme.onPrimaryFixed,
      elevation: kZero,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.large,
        ),
        title: Text(
          LocaleKeys.developers_title.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Icon(
          AppIcons.group,
          size: WidgetSizes.spacingXxl4,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
        onTap: () => const DevelopersRoute().push<DevelopersRoute>(context),
      ),
    );
  }
}
